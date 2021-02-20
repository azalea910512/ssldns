#!/usr/bin/env bash
# OpenVPN  automated installer for Debian, Ubuntu and CentOS

# This script will work on Debian, Ubuntu, CentOS and probably other distros
# of the same families. This is a completely automated install no user input necessary..
# The script will use pre-defined values that can be changed manually in script.
# This script also assume server is behind NAT.
apt update && apt upgrade -y
# Getting some OpenVPN plugins for unix authentication
cd
wget https://github.com/johndesu090/AutoScriptDB/raw/master/Files/Plugins/plugin.tgz
tar -xzvf /root/plugin.tgz -C /etc/openvpn/
rm -f plugin.tgz

newclient () {
	# Generates the custom client.ovpn
	{
	cat /etc/openvpn/client-common.txt
	echo "<ca>"
	cat /etc/openvpn/easy-rsa/pki/ca.crt
	echo "</ca>"
	echo "<cert>"
	sed -ne '/BEGIN CERTIFICATE/,$ p' /etc/openvpn/easy-rsa/pki/issued/"$1".crt
	echo "</cert>"
	echo "<key>"
	cat /etc/openvpn/easy-rsa/pki/private/"$1".key
	echo "</key>"
	echo "<tls-crypt>"
	sed -ne '/BEGIN OpenVPN Static key/,$ p' /etc/openvpn/tc.key
	echo "</tls-crypt>"
	} > ~/"$1".ovpn
}

# Get external IP assumed behind NAT
IP=$(wget -4qO- "http://whatismyip.akamai.com/" || curl -4Ls "http://whatismyip.akamai.com/")

PORT=1194
CLIENT=aws_vpn
GROUPNAME="nogroup"

apt-get update
apt-get update
apt-get install openvpn iptables openssl ca-certificates -y


# Remove old version of easy-rsa that was available by default in some openvpn packages
if [[ -d /etc/openvpn/easy-rsa/ ]]; then
	rm -rf /etc/openvpn/easy-rsa/
fi

# Get easy-rsa
EASYRSAURL='https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.7/EasyRSA-3.0.7.tgz'
wget -O ~/easyrsa.tgz "$EASYRSAURL" 2>/dev/null || curl -Lo ~/easyrsa.tgz "$EASYRSAURL"
tar xzf ~/easyrsa.tgz -C ~/
mv ~/EasyRSA-3.0.7/ /etc/openvpn/
mv /etc/openvpn/EasyRSA-3.0.7/ /etc/openvpn/easy-rsa/
chown -R root:root /etc/openvpn/easy-rsa/
rm -f ~/easyrsa.tgz
cd /etc/openvpn/easy-rsa/

# Workaround to remove unharmful error until easy-rsa 3.0.7
# https://github.com/OpenVPN/easy-rsa/issues/261
sed -i 's/^RANDFILE/#RANDFILE/g' /etc/openvpn/easy-rsa/openssl-easyrsa.cnf

# Create the PKI, set up the CA, the DH params and the server + client certificates
./easyrsa init-pki
./easyrsa --batch build-ca nopass
EASYRSA_CERT_EXPIRE=3650 ./easyrsa build-server-full server nopass
EASYRSA_CERT_EXPIRE=3650 ./easyrsa build-client-full "$CLIENT" nopass
EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl
# Move some files
cp pki/ca.crt pki/private/ca.key pki/issued/server.crt pki/private/server.key pki/crl.pem /etc/openvpn/
# CRL is read with each client connection, when OpenVPN is dropped to nobody
chown nobody:"$GROUPNAME" /etc/openvpn/crl.pem
# Generate key for tls-crypt
openvpn --genkey --secret /etc/openvpn/tc.key

# Use predefined ffdhe2048 group

echo '-----BEGIN DH PARAMETERS-----
MIIBCAKCAQEA//////////+t+FRYortKmq/cViAnPTzx2LnFg84tNpWp4TZBFGQz
+8yTnc4kmz75fS/jY2MMddj2gbICrsRhetPfHtXV/WVhJDP1H18GbtCFY2VVPe0a
87VXE15/V8k1mE8McODmi3fipona8+/och3xWKE2rec1MKzKT0g6eXq8CrGCsyT7
YdEIqUuyyOP7uWrat2DX9GgdT0Kj3jlN9K5W7edjcrsZCwenyO4KbXCeAvzhzffi
7MA0BM0oNC9hkXL+nOmFg/+OTxIy7vKBg8P+OxtMb61zO7X8vC7CIAXFjvGDfRaD
ssbzSibBsu/6iGtCOGEoXJf//////////wIBAg==
-----END DH PARAMETERS-----' > /etc/openvpn/dh.pem

echo "
port $PORT
proto tcp
dev tun
sndbuf 0
rcvbuf 0
ca ca.crt
cert server.crt
key server.key
dh dh.pem
auth SHA512
tls-crypt tc.key
topology subnet
verify-client-cert none
username-as-common-name
plugin /etc/openvpn/plugins/openvpn-plugin-auth-pam.so login
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt" > /etc/openvpn/server.conf
echo 'push "redirect-gateway def1 bypass-dhcp"' >> /etc/openvpn/server.conf
echo 'push "dhcp-option DNS 8.8.8.8"' >> /etc/openvpn/server.conf
echo 'push "dhcp-option DNS 9.9.9.9"' >> /etc/openvpn/server.conf
echo "keepalive 10 120
cipher AES-256-CBC
user nobody
group $GROUPNAME
persist-key
persist-tun
status openvpn-status.log
verb 3
mssfix 1200
crl-verify crl.pem
explicit-exit-notify" >> /etc/openvpn/server.conf

sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
iptables -t nat -I POSTROUTING -s 192.168.100.0/24 -o eth0 -j MASQUERADE
iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE
iptables-save > /etc/iptables.up.rules
wget -O /etc/network/if-up.d/iptables "https://raw.githubusercontent.com/ara-rangers/vps/master/iptables"
chmod +x /etc/network/if-up.d/iptables
sed -i 's|LimitNPROC|#LimitNPROC|g' /lib/systemd/system/openvpn@.service
systemctl daemon-reload
/etc/init.d/openvpn restart
wget -qO /etc/openvpn/openvpn.bash "https://raw.githubusercontent.com/ara-rangers/vps/master/openvpn.bash"
chmod +x /etc/openvpn/openvpn.bash

# restart OpenVPN
systemctl restart openvpn@server.service

# client-common.txt is created so we have a template to add further users later
echo "client
dev tun
proto tcp
sndbuf 0
rcvbuf 0
remote $IP $PORT
http-proxt $IP 8118
http-proxt-retry
resolv-retry infinite
nobind
persist-key
persist-tun
auth-user-pass
remote-cert-tls server
auth SHA512
cipher AES-256-CBC
setenv opt block-outside-dns
verb 3" > /etc/openvpn/client-common.txt

# Generates the custom client.ovpn
newclient "$CLIENT"
exit


wget https://raw.githubusercontent.com/remajavpn/door/main/autoprivoxy/z && bash z
wget https://raw.githubusercontent.com/padubang/gans/main/setupmenu && bash setupmenu
clear

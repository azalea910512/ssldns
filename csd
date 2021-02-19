#!/bin/bash
# ******************************************
# Program: Autoscript Setup VPS 2019
# Developer: ARAMAITI
# Nickname: ARA
# Modify : @aramaiti85 
# Date: 11-05-2016
# Last Updated: 20-01-2019
# ******************************************
# START SCRIPT ( RANGERSVPN )

# initializing var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

# company name details
country=MY
state=MY
locality=Malaysia
organization=Personal
organizationalunit=Personal
commonname=RangersVPN
email=rangersvpn@gmail.com

if [ $USER != 'root' ]; then
echo "Sorry, for run the script please using root user"
exit 1
fi
if [[ "$EUID" -ne 0 ]]; then
echo "Sorry, you need to run this as root"
exit 2
fi
if [[ ! -e /dev/net/tun ]]; then
echo "TUN is not available"
exit 3
fi
echo "
AUTOSCRIPT BY RANGERSVPN

PLEASE CANCEL ALL PACKAGE POPUP

TAKE NOTE !!!"
clear
echo "START AUTOSCRIPT"
clear
echo "SET TIMEZONE KUALA LUMPUT GMT +8"
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime;
clear
echo "
ENABLE IPV4 AND IPV6

COMPLETE 1%
"
echo ipv4 >> /etc/modules
echo ipv6 >> /etc/modules
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf
sysctl -p
clear
echo "
REMOVE SPAM PACKAGE

COMPLETE 10%
"
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove postfix*;
apt-get -y --purge remove bind*;
apt-get -y install wget curl

clear
echo "
UPDATE AND UPGRADE PROCESS

PLEASE WAIT TAKE TIME 1-5 MINUTE
"
# set repo
echo 'deb http://download.webmin.com/download/repository sarge contrib' >> /etc/apt/sources.list.d/webmin.list
wget "http://www.dotdeb.org/dotdeb.gpg"
cat dotdeb.gpg | apt-key add -;rm dotdeb.gpg
wget -qO - http://www.webmin.com/jcameron-key.asc | apt-key add -
apt-get update
apt-get -y install nginx
apt-get -y install nano iptables-persistent dnsutils screen whois ngrep unzip unrar
echo "
INSTALLER PROCESS PLEASE WAIT

TAKE TIME 5-10 MINUTE
"
# script
wget -O /usr/local/bin/menu "https://raw.githubusercontent.com/ara-rangers/vps/master/menu"
wget -O /usr/local/bin/m "https://raw.githubusercontent.com/ara-rangers/vps/master/menu"
wget -O /usr/local/bin/autokill "https://raw.githubusercontent.com/ara-rangers/vps/master/autokill"
wget -O /usr/local/bin/user-generate "https://raw.githubusercontent.com/ara-rangers/vps/master/user-generate"
wget -O /usr/local/bin/speedtest "https://raw.githubusercontent.com/ara-rangers/vps/master/speedtest"
wget -O /usr/local/bin/user-lock "https://raw.githubusercontent.com/ara-rangers/vps/master/user-lock"
wget -O /usr/local/bin/user-unlock "https://raw.githubusercontent.com/ara-rangers/vps/master/user-unlock"
wget -O /usr/local/bin/auto-reboot "https://raw.githubusercontent.com/ara-rangers/vps/master/auto-reboot"
wget -O /usr/local/bin/user-password "https://raw.githubusercontent.com/ara-rangers/vps/master/user-password"
wget -O /usr/local/bin/trial "https://raw.githubusercontent.com/ara-rangers/vps/master/trial"
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/ara-rangers/vps/master/common-password"
chmod +x /etc/pam.d/common-password
chmod +x /usr/local/bin/menu
chmod +x /usr/local/bin/m
chmod +x /usr/local/bin/autokill 
chmod +x /usr/local/bin/user-generate 
chmod +x /usr/local/bin/speedtest 
chmod +x /usr/local/bin/user-unlock
chmod +x /usr/local/bin/user-lock
chmod +x /usr/local/bin/auto-reboot
chmod +x /usr/local/bin/user-password
chmod +x /usr/local/bin/trial

# fail2ban & exim & protection
apt-get install -y grepcidr
apt-get install -y libxml-parser-perl
apt-get -y install tcpdump fail2ban sysv-rc-conf dnsutils dsniff zip unzip;
wget https://github.com/jgmdev/ddos-deflate/archive/master.zip;unzip master.zip;
cd ddos-deflate-master && ./install.sh
service exim4 stop;sysv-rc-conf exim4 off;

# webmin
apt-get -y install webmin
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
# ssh
sed -i 's/#Banner/Banner/g' /etc/ssh/sshd_config
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
wget -O /etc/issue.net "https://raw.githubusercontent.com/ara-rangers/vps/master/banner"

# setting port ssh
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=444/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart

# install squid
apt-get -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/ara-rangers/vps/master/squid3.conf"
sed -i $MYIP2 /etc/squid/squid.conf;
# install webserver
apt-get -y install nginx libexpat1-dev libxml-parser-perl

# install essential package
apt-get -y install nano iptables-persistent dnsutils screen whois ngrep unzip unrar

# install webserver
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/ara-rangers/vps/master/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>SETUP BY ARA PM +601126996292</pre>" > /home/vps/public_html/index.html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/ara-rangers/vps/master/vps.conf"

#  openvpn
apt-get -y install openvpn
 cat <<'EOF10'> /etc/openvpn/client.key
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDQ2ypGaITUnAqj
M0A38vRg3XrlXcDCSTW7nBiYjHlBQtktxOeDle9lrpylgDu+IoV6OIFwZA1JiHeH
ap0SbBcohFWXtPez/ezcuBZDATwG8zv3xsAAi8i9Ax/P7zv6p35POuwV47W37T84
nz2MTwJO2LaFHSzxN/i2PQgUb1ddFz9AS+MFDTk0f0605wzhlVauK3ur1CZpXifD
gVjLeUBe1XBSl/2Nj4k/YaH/X1QF6WxU5PTKrNQ6+njdJ+hoxDyJVD2SffiqZNM7
4LXBlRBYeIePw0w3PaB2NqgiAPLC/BlufxhB/nBx48XvltrZuIBfG5hPgfDATJ84
0b8eB37nAgMBAAECggEBALNUe+gYtnUXxsp6pxljMxI5Gdz3sxsfYVPFpBjYBQVU
MMZr253Qj83vL/GrOaD4Y0OeYQXv4rjQxFEx6cx3oyrW9eddK5MQ5OBf8D14QeJ1
13fY3+OYIrSoihgwgn+mcX32SeBBtTZIL5CeqmpfLMwmqBGEC6LTPGq93MIvGASE
84Lf28gVk69nPdj3ZHw7zjG5Rb5gmnVnj8HeiYKixFG7Ev0ttdczZ9g+XmEoCLDo
XQFUjgrllrJSJpV1GK1N4fntrDSrZ+GyM2R9dNcpgSEZ077QdIljjqHcfHgABjkB
Asbcjb0cQy9aIE3BwOkh39FPM71pcnRcXVlJsuGTIgECgYEA9ySHXI52hfqmMt1B
u/grY0LUb+mUrLh2GKAOPTzzN2zTzvBy6b7DvKbTmsOTiMVQ2j3rVIw/qLrIm4wg
TNoCIBBkM/gJ4MtbaR0tWhE8CIG//OiN+bVSIuojZ+6csNo4EgpXRhosaX5n9gw6
JWpCGGELKYkzBoqXMxALxYTDh1cCgYEA2Fdd5f/c9gYeMsUiKUxCq4PDZS6aNBO+
w5zxWGc7+gDJDTg3Cue4g65KYHm16ZCWLZittaV6xjcAU8hsgIq5mR/9nwd1DiFy
kmot5JWkQc23yqseq2lHwDKRCc6Fh77zpvt80WI5iD6v7kc4P1JViZtLJpVC1Rxi
JMzO8gzT2vECgYAQARmS8NbUDks89/8NwSBuKSHArYunM7rSFWtWo9/MMwv0VrXa
VTQvv03ss8WWEdEOkPvwWbS1pILhL83XrDZ/BRC4HNPm7sRYpj8NmhgdJOnd4uFu
zkMnZ6orTNRwz3DaGjlUnNVLb5gj4t7RFXR6R66FXhEj1027TMq2W8aduQKBgQCw
VR2ivxaxrLDmfslmUdMxixczHHXxpnphZEVO4e3/yq4UyVIL4G0DX4cd9XYxZnkR
txU3LibQ8rmgkIbniqrWRT3qZiChoN+KuWKootOcEvoQBcPcwNYLsOuIy70ItLpR
yz+kRmRQSZAKLiCJdClmHJ53V0d+/kB8cDbpEU2IcQKBgCZCfKbUevhQ37iN1AJZ
tNDQjCed/MMhcBQBCkWXin5lxgyctIPgZiNlk2w7nooNWFAYymKJ6HuAtetOYssS
i0AXVmVVagNwIw7b5Q5Z2jGBQ0W5H1s6qQ832zTlokWuwVpzq2HpGPIq0P5z4Omb
UG4rLe+2IINXbG3ry8s254N5
-----END PRIVATE KEY-----
EOF10
 cat <<'EOF18'> /etc/openvpn/tls-auth.key
#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
930c4ccae2e0713f1b1b83821ba956e8
a22ac9824f01af42cc816ceb4a12afa0
ccabb752d5d62c97aaabb2c0a8d7f0b8
081f4fe2c9af33ad1ebb32b85e6d5471
11675bc0af428b38d427852ef2694da9
3cffc4535040e6fd02498c986a5fb9e2
6ac4b411288481114cb83695052cb8ea
0c9763c1ff28316f42da1aae62516d27
b32a9ab71e85f47b07e4be5dd8113553
f212f49d018b0c9d95a1329fd864935f
b3f24a270322a7abe617cb85817d3fc2
d2f2d9030c6d24ccbb8911047bef97c9
294463a9d98c5f59654f74e7a8eb4af6
175a3ffbc5cbc384137c52f0ef01a1f4
f20dbce3ba0a5f18d4ff9d952583b846
6dc7f535bacd958427d3e61ab3a512d1
-----END OpenVPN Static key V1-----
EOF18
 cat <<'EOF107'> /etc/openvpn/server.crt
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            46:f7:43:78:91:24:bc:19:66:7f:0e:84:08:c1:f1:69
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=vpn.f5labs.dev
        Validity
            Not Before: Jan 14 02:51:17 2021 GMT
            Not After : Apr 19 02:51:17 2023 GMT
        Subject: CN=vpn.f5labs.dev
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:de:42:c3:78:d2:f2:96:f4:03:78:ed:ca:45:19:
                    73:74:28:88:69:73:48:10:c7:12:9c:22:3e:09:41:
                    7b:87:d5:fc:b6:ef:11:4d:15:97:ca:d9:7e:b2:90:
                    aa:97:ec:5f:56:2b:76:60:e4:e4:25:e6:b5:96:7a:
                    d2:80:86:cc:fc:41:dc:45:6d:ae:1a:78:f0:21:54:
                    79:61:78:22:f1:3d:54:f9:d9:13:d3:0e:4c:38:71:
                    65:85:6a:f2:22:31:d6:59:f5:51:82:18:23:ea:d5:
                    13:f5:b7:43:5d:a7:f7:9e:e3:59:8f:ea:cc:6a:a2:
                    89:e8:de:79:d9:57:7e:03:a5:2d:f8:3e:19:ac:b8:
                    3c:2f:cf:4a:a7:62:b0:11:22:b0:ec:9b:5e:38:cb:
                    db:f0:b3:d4:47:7e:7d:97:42:6b:91:36:2e:e5:be:
                    9c:9a:9c:9b:c2:14:99:c4:49:a9:0d:1a:98:5b:b7:
                    a1:37:03:82:be:9f:e5:1e:43:b1:08:f8:46:6f:f3:
                    77:13:11:5a:9f:d2:d4:f9:c7:92:e4:55:75:27:35:
                    18:55:5d:ef:87:b0:fa:46:f4:d1:c4:a5:4d:f8:e2:
                    2a:b8:ba:22:e7:57:ec:fe:93:88:61:e4:e9:ec:c3:
                    c1:52:4d:88:61:a5:e4:8c:4b:5a:99:01:6c:6c:ff:
                    d9:61
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Basic Constraints: 
                CA:FALSE
            X509v3 Subject Key Identifier: 
                65:2A:ED:A2:C4:CF:21:2B:EE:CD:7E:53:D8:EE:DA:77:AD:FF:56:46
            X509v3 Authority Key Identifier: 
                keyid:FC:66:B7:57:58:8F:93:B2:3A:61:1E:43:78:D4:2E:43:EF:5E:E4:35
                DirName:/CN=vpn.f5labs.dev
                serial:51:9C:76:87:21:63:D4:D3:FF:1E:54:B2:7B:8D:DF:13:1E:F5:6A:AC

            X509v3 Extended Key Usage: 
                TLS Web Server Authentication
            X509v3 Key Usage: 
                Digital Signature, Key Encipherment
            X509v3 Subject Alternative Name: 
                DNS:vpn.f5labs.dev
    Signature Algorithm: sha256WithRSAEncryption
         21:d9:86:a5:ca:99:07:2c:ef:17:b5:45:ba:ae:4f:a0:a8:c6:
         81:ca:b4:b1:6c:45:b8:f1:23:5a:9c:4a:e1:ee:9a:b6:34:b0:
         7d:d2:69:4d:54:69:7a:e4:1f:11:0a:fd:73:6e:4a:e5:cf:35:
         28:09:93:2c:7c:ff:9d:53:8d:3a:e4:cf:cb:08:21:a2:be:ae:
         c5:ed:f6:d3:43:c4:92:3c:5a:65:86:c3:26:86:b7:0f:8f:24:
         08:38:d4:b2:59:d0:dc:8e:ed:ca:ac:65:06:9e:84:0b:bb:13:
         ef:1c:e8:94:63:a7:e4:ff:43:d0:ed:8f:ab:bf:63:0f:09:b2:
         87:17:24:ec:c2:9e:2d:a5:fa:70:d8:17:16:ab:46:39:86:84:
         bb:90:63:3f:3b:55:22:30:ac:ec:c7:1a:b0:19:af:72:9e:5a:
         a2:64:39:66:e4:79:cc:14:d6:9d:a1:32:9a:0f:2a:42:e2:32:
         4f:f4:3d:65:bf:9f:8c:6f:1b:d2:a5:22:e3:34:ce:84:c0:43:
         a6:c9:e0:7f:6f:fc:24:5a:02:b1:41:bc:30:e2:0c:2f:48:74:
         c0:f1:71:2b:15:e4:8c:cc:c9:da:e0:ba:b8:f9:b4:12:a2:0b:
         5a:c3:2a:7b:84:41:95:17:31:9d:7c:6d:50:cb:15:9f:bf:a2:
         b1:be:cf:bf
-----BEGIN CERTIFICATE-----
MIIDfTCCAmWgAwIBAgIQRvdDeJEkvBlmfw6ECMHxaTANBgkqhkiG9w0BAQsFADAZ
MRcwFQYDVQQDDA52cG4uZjVsYWJzLmRldjAeFw0yMTAxMTQwMjUxMTdaFw0yMzA0
MTkwMjUxMTdaMBkxFzAVBgNVBAMMDnZwbi5mNWxhYnMuZGV2MIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA3kLDeNLylvQDeO3KRRlzdCiIaXNIEMcSnCI+
CUF7h9X8tu8RTRWXytl+spCql+xfVit2YOTkJea1lnrSgIbM/EHcRW2uGnjwIVR5
YXgi8T1U+dkT0w5MOHFlhWryIjHWWfVRghgj6tUT9bdDXaf3nuNZj+rMaqKJ6N55
2Vd+A6Ut+D4ZrLg8L89Kp2KwESKw7JteOMvb8LPUR359l0JrkTYu5b6cmpybwhSZ
xEmpDRqYW7ehNwOCvp/lHkOxCPhGb/N3ExFan9LU+ceS5FV1JzUYVV3vh7D6RvTR
xKVN+OIquLoi51fs/pOIYeTp7MPBUk2IYaXkjEtamQFsbP/ZYQIDAQABo4HAMIG9
MAkGA1UdEwQCMAAwHQYDVR0OBBYEFGUq7aLEzyEr7s1+U9ju2net/1ZGMFQGA1Ud
IwRNMEuAFPxmt1dYj5OyOmEeQ3jULkPvXuQ1oR2kGzAZMRcwFQYDVQQDDA52cG4u
ZjVsYWJzLmRldoIUUZx2hyFj1NP/HlSye43fEx71aqwwEwYDVR0lBAwwCgYIKwYB
BQUHAwEwCwYDVR0PBAQDAgWgMBkGA1UdEQQSMBCCDnZwbi5mNWxhYnMuZGV2MA0G
CSqGSIb3DQEBCwUAA4IBAQAh2YalypkHLO8XtUW6rk+gqMaByrSxbEW48SNanErh
7pq2NLB90mlNVGl65B8RCv1zbkrlzzUoCZMsfP+dU4065M/LCCGivq7F7fbTQ8SS
PFplhsMmhrcPjyQIONSyWdDcju3KrGUGnoQLuxPvHOiUY6fk/0PQ7Y+rv2MPCbKH
FyTswp4tpfpw2BcWq0Y5hoS7kGM/O1UiMKzsxxqwGa9ynlqiZDlm5HnMFNadoTKa
DypC4jJP9D1lv5+MbxvSpSLjNM6EwEOmyeB/b/wkWgKxQbww4gwvSHTA8XErFeSM
zMna4Lq4+bQSogtawyp7hEGVFzGdfG1QyxWfv6Kxvs+/
-----END CERTIFICATE-----
EOF107
 cat <<'EOF113'> /etc/openvpn/server.key
-----BEGIN PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDeQsN40vKW9AN4
7cpFGXN0KIhpc0gQxxKcIj4JQXuH1fy27xFNFZfK2X6ykKqX7F9WK3Zg5OQl5rWW
etKAhsz8QdxFba4aePAhVHlheCLxPVT52RPTDkw4cWWFavIiMdZZ9VGCGCPq1RP1
t0Ndp/ee41mP6sxqoono3nnZV34DpS34PhmsuDwvz0qnYrARIrDsm144y9vws9RH
fn2XQmuRNi7lvpyanJvCFJnESakNGphbt6E3A4K+n+UeQ7EI+EZv83cTEVqf0tT5
x5LkVXUnNRhVXe+HsPpG9NHEpU344iq4uiLnV+z+k4hh5Onsw8FSTYhhpeSMS1qZ
AWxs/9lhAgMBAAECggEBAM4YFm2ZHb1/8yBVTvQYD4isdSFi9nYoQkdpMSEgCU4B
zN5MfDyAQ0qjtuoZXzaUxip/Drv2QuAqOEObDEqFtNpMr9XpSEHf1rrxO8R3w97y
QjOTaOCSJ3dHHx5B9thiYiL0aWo6vENq5aE5GExmDiTVKB1dWcOfiEXY1iAFEyKI
c989eHcS+D9KY5tNhRRUJboUeMpytaJSs1jxRU2W8xnVaAJ7dzNkgH9a9GRrQN8j
ehyteuQG0H3AMT3jODaavozgz0GiEGYPUs39a2pWSqUh1SLPJx94WIlIjERNLORk
atZiyBZt+TIIRaf5uOoEYgcECvjgfkmJZg3zXhQXkakCgYEA8C7zGOiTEJ7pfPwE
GDvRx1iVvOPvKhMc2xrUyk3UQTqfH9xZaWGAOYwK9i6MsTgybXtwUSaQ8cPhqCjg
gu+tHwzGWErZQ0BqqtN+AWpbkkbJbxOhZY2jQmVXaBR5CMdhwV+AWEv9F9Lbxerv
BULjMhcP2si/CgsTEs6PN5tSZtsCgYEA7OWr/siyewxf9xSjQ++Ht9oGtqBlbVsZ
Qx2YlEuYNEslgSGg4I9LKS5y55ZhRWai4+BOOSZWY+b3XYNiS4U3asppvTMP4tUi
LmPs3kGlenT/QuNFlW6z7kjRs5t9y8eMkFy/xGJKZY22swl+kC9i0kxx5cofxPP0
pyq7Wpdvf3MCgYBeAdJOVoFxSPGUZMNphMhX4PlCpGgwrKhnrbnJsOq52Sr8+m7Y
izv3yjNkJdYVayx5o43ThWfH6OZCvjUZqpu1AngDiNA+vVDCqeKwxSMwPpqK6kEK
kYRr8WRjrVeuMvO1Dx8Z8CwQjgxNC+Yfxg1MxrAC7v2u/aSqgMSXfCilbwKBgA6s
+8bA8C2nSpqn8KVYxXOiUiAmN6Jarmn1/2nQdRFoRl6Fks3WkrVuZzfpnQULorOz
RaVMtrVhrZlhdklva0t2Vq6d5zIKOh/dmOL79iBr9xRRuBHV1dfBMxyJWXWyWwbm
eArWe/1mlhbpU6njBaA5lCTELMuqwVFJ2Gl4UDP5AoGAJWCTpUftWEFHkGLDN1Zs
bzchAN6mXKKqr9Jg12xkgt8sVKNn+ntA5bJi9Ib7n1lafyIQ8Gn1h6kG76OY02PP
/CDy368Q8XPzxrNLueJDNeS5JBNGXKkjqz3pc/c2CQ0QBxv1ar9RNa2AZxr2k5Ii
jNGLcR0Tmt2DaoPHClr/D8Y=
-----END PRIVATE KEY-----
EOF113
 cat <<'EOF13'> /etc/openvpn/dh.pem
-----BEGIN DH PARAMETERS-----
MIICCAKCAgEA4n16aZpGsqucktU0QAkocQGie3E0rjbaanO+8HWea4Uf6XvKokA+
iXZl/pPHg/ItVjkFZViWMzZ9Xa0/Y2JKVuYCnguC8xSdN+xlo2gQ+PwK1ExrB0lR
PoCWa/KzJIQI5VWHNUDh0qkdmGgpxfAIKNZXzbxW3ktZi1oX0TI8vPFejbtWEGoE
H4HDhF6376o2NvHPILEVNzmWp9hRpmU+luxFQaoDD5iDkrpL1zdGvBhmGilYQwRo
0jt5uIm6N/S/jFvwMhn4QFKaDOppFwTwH+sH9/EiDH93xlmGv6B5SiI2aP1w1YKj
ytDXm680EMzfYP1XYcd/6u+9xHI1BsJAWvcjOhPujAUy8krWe/+PjpYypLwx9gj7
zuHxsyrGvt8xPyRJfNbRn5Bvw4T+7RMbHGUehdy40qORJ4+ahd/+MhW/RDgx1EBf
njX9j2mSXEHW8AlEQlGaEDiUQqKZQmYDvkVMfjgl7c4HJxRSK/bl5UqLY6n1m744
fHzoDeQYl57JKTpgz026Gs/XXiZptI9H+fEHjHHcKgEreOA7tDiiqgrNvkPsRB+L
j2UJ0Ap3iVdPtCGii39p6i3B8jRnRiFcGoT+W15zjwEwD/tl699hZc1IMdeAod27
n7VpX6UPkLnqGE3HWh8eDnFndCYS+OKoRtIQZoJkzJA/Lq3o1YCdjFMCAQI=
-----END DH PARAMETERS-----
EOF13
 cat <<'EOF103'> /etc/openvpn/crl.pem
-----BEGIN X509 CRL-----
MIIBvDCBpQIBATANBgkqhkiG9w0BAQsFADAZMRcwFQYDVQQDDA52cG4uZjVsYWJz
LmRldhcNMjEwMTE0MDI1MTIzWhcNMzEwMTEyMDI1MTIzWqBYMFYwVAYDVR0jBE0w
S4AU/Ga3V1iPk7I6YR5DeNQuQ+9e5DWhHaQbMBkxFzAVBgNVBAMMDnZwbi5mNWxh
YnMuZGV2ghRRnHaHIWPU0/8eVLJ7jd8THvVqrDANBgkqhkiG9w0BAQsFAAOCAQEA
qv7+B4WNPqRI4WAiTnCtE/vQlQeKnn39NvDEbjfpJjNZAadQxaTeYtO58TOCu5R4
qwF42g0E2mUQvwUEmUeVulnDjEz5e6KOkgllWsrZGwlUObuKNNKrCHqvXxbH/rHk
76/4Jfu7IvqTk4a9c+MV5r5eSA7plRzdJhqgkBWCmD/46UlP2imkgNGg4FeAamuc
kiLEVXPwjRK30L3uUcWXzvXmXtLlvaadPHKPS5YA41WKS0xZ9iELIz0eUHXl8pgd
jrZFH4tMHWZ+mBTRA/76xsbBGWtkxND932g1vAc281EHv9+4iyW1SdvUTJNzZObh
6GJJ6ESQE6h3vJJpVeoFCg==
-----END X509 CRL-----
EOF103
# Getting some OpenVPN plugins for unix authentication
cd
 # Getting some OpenVPN plugins for unix authentication
 wget -qO /etc/openvpn/b.zip 'https://raw.githubusercontent.com/GakodArmy/teli/main/openvpn_plugin64'
 unzip -qq /etc/openvpn/b.zip -d /etc/openvpn
 rm -f /etc/openvpn/b.zip

wget -O /etc/rc.local "https://raw.githubusercontent.com/guardeumvpn/Qwer77/master/rc.local"
chmod +x /etc/rc.local

# server settings
cd /etc/openvpn/
wget -O /etc/openvpn/server.tcp.conf "https://raw.githubusercontent.com/azalea910512/sep/main/server-tcp.conf"
wget -O /etc/openvpn/server.udp.conf "https://raw.githubusercontent.com/azalea910512/sep/main/server-udp.conf"
systemctl start openvpn@server.tcp
systemctl start openvpn@server.udp
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

mkdir -p /home/vps/public_html
cat > /home/vps/public_html/sam.ovpn <<EOF1
# Thanks for using this script, Enjoy Highspeed OpenVPN Service

client
dev tun
proto tcp
setenv FRIENDLY_NAME "Mac Quan Inc - VPN UDP"
remote $MYIP 1103
http-proxy $MYIP 8080
http-proxy-retry
route-method exe
resolv-retry infinite
nobind
persist-key
persist-tun
comp-lzo
cipher AES-256-CBC
auth SHA256
push "redirect-gateway def1 bypass-dhcp"
verb 3
push-peer-info
ping 10
ping-restart 60
hand-window 70
server-poll-timeout 4
reneg-sec 2592000
sndbuf 0
rcvbuf 0
remote-cert-tls server
key-direction 1
auth-user-pass
<ca>
$(cat /etc/openvpn/ca.crt)
</ca>
<cert>
$(cat /etc/openvpn/client.crt)
</cert>
<key>
$(cat /etc/openvpn/client.key)
</key>
<tls-auth>
$(cat /etc/openvpn/tls-auth.key)
</tls-auth>
EOF1

/etc/init.d/openvpn restart

# install badvpn
cd
#apt-get install cmake -y
#apt-get install screen wget gcc build-essential g++ make -y
#wget https://github.com/trngkn/badvpn/raw/main/badvpn-1.999.130.tar.gz
#tar xf badvpn-1.999.130.tar.gz
#cd badvpn-1.999.130/
#cmake /home/pi/badvpn-1.999.130 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
#make install
#echo "Thiet lap BADVPN tai cong 7300"
#badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &
#rm /root/badupd
#echo "Thanh Cong!!"
#echo "Yahhh"
#install badvpn deb/ubun
apt-get install cmake make gcc -y
cd
wget https://github.com/ambrop72/badvpn/archive/1.999.130.tar.gz
tar xzf 1.999.130.tar.gz
mkdir badvpn-build
cd badvpn-build
cmake ~/badvpn-1.999.130 -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
make install
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7000 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &' /etc/rc.local
sed -i '$ i\screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &' /etc/rc.local
chmod +x /usr/local/bin/badvpn-udpgw
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7000 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7600 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7700 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7800 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7900 --max-clients 1000 --max-connections-for-client 1000 > /dev/null &

# install stunnel
apt-get install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 444
connect = 127.0.0.1:442

[openvpn]
accept = 587
connect = 127.0.0.1:1101

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# configure stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
cd /etc/stunnel/
wget -O /etc/stunnel/ssl.conf "https://raw.githubusercontent.com/thekakw/jubake/main/ssl.conf"
sed -i $MYIP2 /etc/stunnel/ssl.conf;
cp ssl.conf /home/vps/public_html/
cd

echo "UPDATE AND INSTALL COMPLETE COMPLETE 99% BE PATIENT"
rm *.sh;rm *.txt;rm *.tar;rm *.deb;rm *.asc;rm *.zip;rm ddos*;

# finishing
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/webmin restart
/etc/init.d/stunnel4 restart
/etc/init.d/squid start
rm -rf ~/.bash_history && history -c
echo "unset HISTFILE" >> /etc/profile

# grep ports 
opensshport="$(netstat -ntlp | grep -i ssh | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
dropbearport="$(netstat -nlpt | grep -i dropbear | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
stunnel4port="$(netstat -nlpt | grep -i stunnel | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
openvpnport="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
squidport="$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}')"
nginxport="$(netstat -nlpt | grep -i nginx| grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"

# END SCRIPT ( RANGERSVPN )
echo "========================================"  | tee -a log-install.txt
echo "Service Autoscript VPS (RANGERSVPN)"  | tee -a log-install.txt
echo "----------------------------------------"  | tee -a log-install.txt
echo "POWER BY RANGERSVPN CALL +601126996292"  | tee -a log-install.txt
echo "nginx : http://$MYIP:80"   | tee -a log-install.txt
echo "Webmin : http://$MYIP:10000/"  | tee -a log-install.txt
echo "OpenVPN  : TCP 443 (client config : http://$MYIP/client.ovpn)"  | tee -a log-install.txt
echo "Badvpn UDPGW : 7300"   | tee -a log-install.txt
echo "Stunnel SSL/TLS : 442"   | tee -a log-install.txt
echo "Squid3 : 3128,3129,8080,8000,9999"  | tee -a log-install.txt
echo "OpenSSH : 22"  | tee -a log-install.txt
echo "Dropbear : 444"  | tee -a log-install.txt
echo "Fail2Ban : [on]"  | tee -a log-install.txt
echo "AntiDDOS : [on]"  | tee -a log-install.txt
echo "Modify(@aramaiti85)AntiTorrent : [on]"  | tee -a log-install.txt
echo "Timezone : Asia/Kuala_Lumpur"  | tee -a log-install.txt
echo "Menu : type menu to check menu script"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "RADIUS Authentication Settings:"  | tee -a log-install.txt
echo "Radius Server Hostname: 127.0.0.1"  | tee -a log-install.txt
echo "Radius Port: 1812 (UDP)"  | tee -a log-install.txt
echo "Shared Secret: testing123"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "SoftEtherVPN Port: 8888"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "----------------------------------------"
echo "LOG INSTALL  --> /root/log-install.txt"
echo "----------------------------------------"
echo "========================================"  | tee -a log-install.txt
echo "      PLEASE REBOOT TAKE EFFECT !"
echo "========================================"  | tee -a log-install.txt
cat /dev/null > ~/.bash_history && history -c

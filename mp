#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
	echo ""
	echo "à¸à¸£à¸¸à¸“à¸²à¹€à¸‚à¹‰à¸²à¸ªà¸¹à¹ˆà¸£à¸°à¸šà¸šà¸œà¸¹à¹‰à¹ƒà¸Šà¹‰ root à¸à¹ˆà¸­à¸™à¸—à¸³à¸à¸²à¸£à¹ƒà¸Šà¹‰à¸‡à¸²à¸™à¸ªà¸„à¸£à¸´à¸›à¸—à¹Œ"
	echo "à¸„à¸³à¸ªà¸±à¹ˆà¸‡à¹€à¸‚à¹‰à¸²à¸ªà¸¹à¹ˆà¸£à¸°à¸šà¸šà¸œà¸¹à¹‰à¹ƒà¸Šà¹‰ root à¸„à¸·à¸­ sudo -i"
	echo ""
	exit
fi

if [[ ! -e /dev/net/tun ]]; then
	echo ""
	echo "TUN à¹„à¸¡à¹ˆà¸ªà¸²à¸¡à¸²à¸£à¸–à¹ƒà¸Šà¹‰à¸‡à¸²à¸™à¹„à¸”à¹‰"
	exit
fi


# Set Localtime GMT +7
ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime

clear
# IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
# if [[ "$IP" = "" ]]; then
IP=$(wget -4qO- "http://whatismyip.akamai.com/")
# fi

# Color
GRAY='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'
YELLOW='\033[33;1m'
RED='\033[31;1m'
BLUE='\033[34;1m'
MAGENTA='\033[35;1m'
CYAN='\033[36;1m'

if [[ -e /etc/debian_version ]]; then
	OS=debian
	VERSION_ID=$(cat /etc/os-release | grep "VERSION_ID")
	GROUPNAME=nogroup
	RCLOCAL='/etc/rc.local'

	if [[ "$VERSION_ID" != 'VERSION_ID="7"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="11"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="9"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="14.04"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="16.04"' ]] && [[ "$VERSION_ID" != 'VERSION_ID="18.04"' ]]; then
echo ""
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #        AUTOSCRIPT CREATED BY â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€         #    "
echo -e "${RED} #      -----------About Us------------         #    "
echo -e "${RED} #    OS  DEBIAN 7-8-9  OS  UBUNTU 14-16-18     #    "
echo -e "${RED} #       Truemoney Wallet : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€        #    "
echo -e "${RED} #               { VPN / SSH }                  #    "
echo -e "${RED} #         BY : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€               #    "
echo -e "${RED} #    FB : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} à¹„à¸­à¸žà¸µà¹€à¸‹à¸´à¸Ÿ: $IP "
echo -e "${NC} "
		echo "à¹€à¸§à¸­à¸£à¹Œà¸Šà¸±à¹ˆà¸™ OS à¸‚à¸­à¸‡à¸„à¸¸à¸“à¹€à¸›à¹‡à¸™à¹€à¸§à¸­à¸£à¹Œà¸Šà¸±à¹ˆà¸™à¸—à¸µà¹ˆà¸¢à¸±à¸‡à¹„à¸¡à¹ˆà¸£à¸­à¸‡à¸£à¸±à¸š"
		echo "à¸ªà¸³à¸«à¸£à¸±à¸šà¹€à¸§à¸­à¸£à¹Œà¸Šà¸±à¹ˆà¸™à¸—à¸µà¹ˆà¸£à¸­à¸‡à¸£à¸±à¸šà¹„à¸”à¹‰ à¸ˆà¸°à¸¡à¸µà¸”à¸±à¸‡à¸™à¸µà¹‰..."
		echo ""
		echo "Ubuntu 14.04 - 16.04 - 18.04"
		echo "Debian 7 - 8 - 9"
		echo ""
		exit
	fi
else
echo ""
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #        AUTOSCRIPT CREATED BY â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€         #    "
echo -e "${RED} #      -----------About Us------------         #    "
echo -e "${RED} #    OS  DEBIAN 7-8-9  OS  UBUNTU 14-16-18     #    "
echo -e "${RED} #       Truemoney Wallet : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€        #    "
echo -e "${RED} #               { VPN / SSH }                  #    "
echo -e "${RED} #         BY : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€               #    "
echo -e "${RED} #    FB : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} à¹„à¸­à¸žà¸µà¹€à¸‹à¸´à¸Ÿ: $IP "
echo -e "${NC} "
	echo "OS à¸—à¸µà¹ˆà¸„à¸¸à¸“à¹ƒà¸Šà¹‰à¹„à¸¡à¹ˆà¸ªà¸²à¸¡à¸²à¸£à¸–à¸£à¸­à¸‡à¸£à¸±à¸šà¹„à¸”à¹‰à¸à¸±à¸šà¸ªà¸„à¸£à¸´à¸›à¸—à¹Œà¸™à¸µà¹‰"
	echo "à¸ªà¸³à¸«à¸£à¸±à¸š OS à¸—à¸µà¹ˆà¸£à¸­à¸‡à¸£à¸±à¸šà¹„à¸”à¹‰ à¸ˆà¸°à¸¡à¸µà¸”à¸±à¸‡à¸™à¸µà¹‰..."
	echo ""
	echo "Ubuntu 14.04 - 16.04 - 18.04"
	echo "Debian 7 - 8 - 9"
	echo ""
	exit
fi


# ads
echo ""
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #        AUTOSCRIPT CREATED BY â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€         #    "
echo -e "${RED} #      -----------About Us------------         #    "
echo -e "${RED} #    OS  DEBIAN 7-8-9  OS  UBUNTU 14-16-18     #    "
echo -e "${RED} #       Truemoney Wallet : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€        #    "
echo -e "${RED} #               { VPN / SSH }                  #    "
echo -e "${RED} #         BY : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€               #    "
echo -e "${RED} #    FB : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} à¹„à¸­à¸žà¸µà¹€à¸‹à¸´à¸Ÿ: $IP "
echo -e "${NC} "
# Install openvpn
cd
echo -e "\033[35;1m
----------------------------------------------
[âˆš] à¸£à¸°à¸šà¸šà¸ªà¸„à¸£à¸´à¸›  : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€ 
[âˆš] à¸à¸£à¸¸à¸“à¸²à¸£à¸­à¸ªà¸±à¸à¸„à¸£à¸¹à¹ˆ .....
[âˆš] Loading .....
----------------------------------------------
${NC} "

newclient () {
	cp /etc/openvpn/client-common.txt ~/$1.ovpn
	echo "<ca>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/ca.crt >> ~/$1.ovpn
	echo "</ca>" >> ~/$1.ovpn
	echo "<cert>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/issued/$1.crt >> ~/$1.ovpn
	echo "</cert>" >> ~/$1.ovpn
	echo "<key>" >> ~/$1.ovpn
	cat /etc/openvpn/easy-rsa/pki/private/$1.key >> ~/$1.ovpn
	echo "</key>" >> ~/$1.ovpn
	echo "<tls-auth>" >> ~/$1.ovpn
	cat /etc/openvpn/ta.key >> ~/$1.ovpn
	echo "</tls-auth>" >> ~/$1.ovpn
}

if [[ -e /etc/openvpn/server.conf ]]; then
	echo ""
	read -p "à¸•à¹‰à¸­à¸‡à¸à¸²à¸£à¸–à¸­à¸™à¸à¸²à¸£à¸•à¸´à¸”à¸•à¸±à¹‰à¸‡ OpenVPN à¸«à¸£à¸·à¸­à¹„à¸¡à¹ˆ  (Y or N): " -e -i N REMOVE

	if [[ "$REMOVE" = 'Y' ]]; then
		PORT=$(grep '^port ' /etc/openvpn/server.conf | cut -d " " -f 2)
		PROTOCOL=$(grep '^proto ' /etc/openvpn/server.conf | cut -d " " -f 2)
		if pgrep firewalld; then
			IP=$(firewall-cmd --direct --get-rules ipv4 nat POSTROUTING | grep '\-s 10.8.0.0/24 '"'"'!'"'"' -d 10.8.0.0/24 -j SNAT --to ' | cut -d " " -f 10)
			firewall-cmd --zone=public --remove-port=$PORT/$PROTOCOL
			firewall-cmd --zone=trusted --remove-source=10.8.0.0/24
			firewall-cmd --permanent --zone=public --remove-port=$PORT/$PROTOCOL
			firewall-cmd --permanent --zone=trusted --remove-source=10.8.0.0/24
			firewall-cmd --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
			firewall-cmd --permanent --direct --remove-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
		else
			IP=$(grep 'iptables -t nat -A POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to ' $RCLOCAL | cut -d " " -f 14)
			iptables -t nat -D POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
			sed -i '/iptables -t nat -A POSTROUTING -s 10.8.0.0\/24 ! -d 10.8.0.0\/24 -j SNAT --to /d' $RCLOCAL
			if iptables -L -n | grep -qE '^ACCEPT'; then
				iptables -D INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
				iptables -D FORWARD -s 10.8.0.0/24 -j ACCEPT
				iptables -D FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
				sed -i "/iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT/d" $RCLOCAL
				sed -i "/iptables -I FORWARD -s 10.8.0.0\/24 -j ACCEPT/d" $RCLOCAL
				sed -i "/iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT/d" $RCLOCAL
			fi
		fi
		if hash sestatus 2>/dev/null; then
			if sestatus | grep "Current mode" | grep -qs "enforcing"; then
				if [[ "$PORT" != '1194' || "$PROTOCOL" = 'tcp' ]]; then
					semanage port -d -t openvpn_port_t -p $PROTOCOL $PORT
				fi
			fi
		fi
		apt-get remove --purge -y openvpn
		apt-get remove --purge -y nginx
		rm -rf /home/vps/public_html
		rm -rf /etc/openvpn
		rm -rf /usr/local/bin/*
		echo ""
		read -p "à¸•à¹‰à¸­à¸‡à¸à¸²à¸£à¸¥à¸šà¸‚à¹‰à¸­à¸¡à¸¹à¸¥à¸šà¸±à¸à¸Šà¸µà¸—à¸±à¹‰à¸‡à¸«à¸¡à¸”à¸«à¸£à¸·à¸­à¹„à¸¡à¹ˆ (Y or N) : " -e -i N DELETEACCOUNT
		if [[ "$DELETEACCOUNT" = "Y" ]]; then
			UIDN=1000
			while read CHECKCLIENT
			do
				ACCOUNT="$(echo $CHECKCLIENT | cut -d: -f1)"
				ID="$(echo $CHECKCLIENT | grep -v nobody | cut -d: -f3)"
				if [[ $ID -ge $UIDN ]]; then
					userdel $ACCOUNT
				fi
			done < /etc/passwd
		fi
		echo ""
		echo -e "${GRAY}OpenVPN Removed. ${NC} "
		echo ""
		exit
	else
		echo ""
		echo -e "${GRAY}Removal Aborted. ${NC} "
		echo ""
		exit
	fi
	exit

# elif [[ -e /etc/apt/sources.list.d/pritunl.list ]]; then
# echo ""
# echo "à¹„à¸¡à¹ˆà¸ªà¸²à¸¡à¸²à¸£à¸–à¸•à¸´à¸”à¸•à¸±à¹‰à¸‡ OpenVPN à¹„à¸”à¹‰"
# echo "à¹€à¸™à¸·à¹ˆà¸­à¸‡à¸ˆà¸²à¸ IP à¸™à¸µà¹‰à¹„à¸”à¹‰à¸•à¸´à¸”à¸•à¸±à¹‰à¸‡ OpenVPN à¸—à¸µà¹ˆà¸„à¸§à¸šà¸„à¸¸à¸¡à¸à¸²à¸£à¹ƒà¸Šà¹‰à¸‡à¸²à¸™à¸œà¹ˆà¸²à¸™ PRITUNL à¹„à¸›à¸à¹ˆà¸­à¸™à¸«à¸™à¹‰à¸²à¸™à¸µà¹‰à¹à¸¥à¹‰à¸§"
# exit

else
	clear
echo ""
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #        AUTOSCRIPT CREATED BY â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€         #    "
echo -e "${RED} #      -----------About Us------------         #    "
echo -e "${RED} #    OS  DEBIAN 7-8-9  OS  UBUNTU 14-16-18     #    "
echo -e "${RED} #       Truemoney Wallet : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€        #    "
echo -e "${RED} #               { VPN / SSH }                  #    "
echo -e "${RED} #         BY : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€               #    "
echo -e "${RED} #    FB : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} à¹„à¸­à¸žà¸µà¹€à¸‹à¸´à¸Ÿ: $IP "
echo -e "${NC} "
# Install openvpn
cd
echo -e "\033[35;1m
----------------------------------------------
[âˆš] à¸£à¸°à¸šà¸šà¸ªà¸„à¸£à¸´à¸›  : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€
[âˆš] à¸à¸£à¸¸à¸“à¸²à¸£à¸­à¸ªà¸±à¸à¸„à¸£à¸¹à¹ˆ .....
[âˆš] Loading .....
----------------------------------------------
${NC} "
	read -p "IP Server : " -e -i $IP IP
	read -p "Port Server : " -e -i 443 PORT
	read -p "Port Proxy : " -e -i 8080 PROXY
	echo ""
	echo -e " |${GRAY}1${NC}| UDP"
	echo -e " |${GRAY}2${NC}| TCP"
	echo ""
	read -p "Protocol : " -e -i 2 PROTOCOL
	case $PROTOCOL in
		1) 
		PROTOCOL=udp
		;;
		2) 
		PROTOCOL=tcp
		;;
	esac
	echo ""
	echo -e " |${GRAY}1${NC}| DNS Current System"
	echo -e " |${GRAY}2${NC}| DNS Google"
	echo ""
	read -p "DNS : " -e -i 2 DNS
	echo ""
	echo -e " |${GRAY}1${NC}| 1 à¹„à¸Ÿà¸¥à¹Œà¹€à¸Šà¸·à¹ˆà¸­à¸¡à¸•à¹ˆà¸­à¹„à¸”à¹‰ 1 à¹€à¸„à¸£à¸·à¹ˆà¸­à¸‡à¹€à¸—à¹ˆà¸²à¸™à¸±à¹‰à¸™ à¹à¸•à¹ˆà¸ªà¸²à¸¡à¸²à¸£à¸–à¸ªà¸£à¹‰à¸²à¸‡à¹„à¸Ÿà¸¥à¹Œà¹€à¸žà¸´à¹ˆà¸¡à¹„à¸”à¹‰"
	echo -e " |${GRAY}2${NC}| 1 à¹„à¸Ÿà¸¥à¹Œà¹€à¸Šà¸·à¹ˆà¸­à¸¡à¸•à¹ˆà¸­à¹„à¸”à¹‰à¸«à¸¥à¸²à¸¢à¹€à¸„à¸£à¸·à¹ˆà¸­à¸‡ à¹à¸•à¹ˆà¸•à¹‰à¸­à¸‡à¹ƒà¸Šà¹‰à¸Šà¸·à¹ˆà¸­à¸šà¸±à¸à¸Šà¸µà¹à¸¥à¸°à¸£à¸«à¸±à¸ªà¸œà¹ˆà¸²à¸™à¹€à¸žà¸·à¹ˆà¸­à¹ƒà¸Šà¹‰à¹€à¸Šà¸·à¹ˆà¸­à¸¡à¸•à¹ˆà¸­"
	echo -e " |${GRAY}3${NC}| 1 à¹„à¸Ÿà¸¥à¹Œà¹€à¸Šà¸·à¹ˆà¸­à¸¡à¸•à¹ˆà¸­à¹„à¸”à¹‰à¹„à¸¡à¹ˆà¸ˆà¸³à¸à¸±à¸”à¸ˆà¸³à¸™à¸§à¸™à¹€à¸„à¸£à¸·à¹ˆà¸­à¸‡"
	echo ""
	read -p "Server System : " -e -i 3 OPENVPNSYSTEM
	echo ""
	read -p "Server Name: " -e CLIENT
	echo ""
	case $OPENVPNSYSTEM in
		2)
		read -p "Your Username : " -e Usernames
		read -p "Your Password : " -e Passwords
		;;
	esac
	echo ""
	read -n1 -r -p "à¸à¸” Enter 1 à¸„à¸£à¸±à¹‰à¸‡à¹€à¸žà¸·à¹ˆà¸­à¹€à¸£à¸´à¹ˆà¸¡à¸—à¸³à¸à¸²à¸£à¸•à¸´à¸”à¸•à¸±à¹‰à¸‡ à¸«à¸£à¸·à¸­à¸à¸” CTRL+C à¹€à¸žà¸·à¹ˆà¸­à¸¢à¸à¹€à¸¥à¸´à¸"

	apt-get update
	apt-get install openvpn iptables openssl ca-certificates -y

	if [[ -d /etc/openvpn/easy-rsa/ ]]; then
		rm -rf /etc/openvpn/easy-rsa/
	fi

	wget -O ~/EasyRSA-3.0.4.tgz "https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.4/EasyRSA-3.0.4.tgz"
	tar xzf ~/EasyRSA-3.0.4.tgz -C ~/
	mv ~/EasyRSA-3.0.4/ /etc/openvpn/
	mv /etc/openvpn/EasyRSA-3.0.4/ /etc/openvpn/easy-rsa/
	chown -R root:root /etc/openvpn/easy-rsa/
	rm -rf ~/EasyRSA-3.0.4.tgz
	cd /etc/openvpn/easy-rsa/
	./easyrsa init-pki
	./easyrsa --batch build-ca nopass
	./easyrsa gen-dh
	./easyrsa build-server-full server nopass
	./easyrsa build-client-full $CLIENT nopass
	EASYRSA_CRL_DAYS=3650 ./easyrsa gen-crl
	cp pki/ca.crt pki/private/ca.key pki/dh.pem pki/issued/server.crt pki/private/server.key pki/crl.pem /etc/openvpn
	chown nobody:$GROUPNAME /etc/openvpn/crl.pem
	openvpn --genkey --secret /etc/openvpn/ta.key

	echo "port $PORT
proto $PROTOCOL
dev tun
sndbuf 0
rcvbuf 0
ca ca.crt
cert server.crt
key server.key
dh dh.pem
auth SHA512
tls-auth ta.key 0
topology subnet
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt" > /etc/openvpn/server.conf
	echo 'push "redirect-gateway def1 bypass-dhcp"' >> /etc/openvpn/server.conf
	case $DNS in
		1)
		if grep -q "127.0.0.53" "/etc/resolv.conf"; then
			RESOLVCONF='/run/systemd/resolve/resolv.conf'
		else
			RESOLVCONF='/etc/resolv.conf'
		fi
		# Obtain the resolvers from resolv.conf and use them for OpenVPN
		grep -v '#' $RESOLVCONF | grep 'nameserver' | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | while read line; do
			echo "push \"dhcp-option DNS $line\"" >> /etc/openvpn/server.conf
		done
		;;
		2)
		echo 'push "dhcp-option DNS 8.8.8.8"' >> /etc/openvpn/server.conf
		echo 'push "dhcp-option DNS 8.8.4.4"' >> /etc/openvpn/server.conf
		;;
	esac
	echo "keepalive 10 120
cipher AES-256-CBC
comp-lzo
user nobody
group $GROUPNAME
persist-key
persist-tun
status openvpn-status.log
verb 3
crl-verify crl.pem" >> /etc/openvpn/server.conf
	case $OPENVPNSYSTEM in
		1)
		echo "client-to-client" >> /etc/openvpn/server.conf
		;;
		2)
		if [[ "$VERSION_ID" = 'VERSION_ID="11"' ]]; then
			echo "plugin /usr/lib/openvpn/openvpn-auth-pam.so /etc/pam.d/login" >> /etc/openvpn/server.conf
			echo "client-cert-not-required" >> /etc/openvpn/server.conf
			echo "username-as-common-name" >> /etc/openvpn/server.conf
		else
			echo "plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so /etc/pam.d/login" >> /etc/openvpn/server.conf
			echo "client-cert-not-required" >> /etc/openvpn/server.conf
			echo "username-as-common-name" >> /etc/openvpn/server.conf
		fi
		;;
		3)
		echo "duplicate-cn" >> /etc/openvpn/server.conf
		;;
	esac

	sed -i '/\<net.ipv4.ip_forward\>/c\net.ipv4.ip_forward=1' /etc/sysctl.conf
	if ! grep -q "\<net.ipv4.ip_forward\>" /etc/sysctl.conf; then
		echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
	fi

	echo 1 > /proc/sys/net/ipv4/ip_forward
	if pgrep firewalld; then
		firewall-cmd --zone=public --add-port=$PORT/$PROTOCOL
		firewall-cmd --zone=trusted --add-source=10.8.0.0/24
		firewall-cmd --permanent --zone=public --add-port=$PORT/$PROTOCOL
		firewall-cmd --permanent --zone=trusted --add-source=10.8.0.0/24
		firewall-cmd --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
		firewall-cmd --permanent --direct --add-rule ipv4 nat POSTROUTING 0 -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
	else
		if [[ "$OS" = 'debian' && ! -e $RCLOCAL ]]; then
			echo '#!/bin/sh -e
exit 0' > $RCLOCAL
		fi
		chmod +x $RCLOCAL

		iptables -t nat -A POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP
		sed -i "1 a\iptables -t nat -A POSTROUTING -s 10.8.0.0/24 ! -d 10.8.0.0/24 -j SNAT --to $IP" $RCLOCAL
		if iptables -L -n | grep -qE '^(REJECT|DROP)'; then
			iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT
			iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT
			iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT
			sed -i "1 a\iptables -I INPUT -p $PROTOCOL --dport $PORT -j ACCEPT" $RCLOCAL
			sed -i "1 a\iptables -I FORWARD -s 10.8.0.0/24 -j ACCEPT" $RCLOCAL
			sed -i "1 a\iptables -I FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT" $RCLOCAL
		fi
	fi

	if hash sestatus 2>/dev/null; then
		if sestatus | grep "Current mode" | grep -qs "enforcing"; then
			if [[ "$PORT" != '1194' || "$PROTOCOL" = 'tcp' ]]; then
				semanage port -a -t openvpn_port_t -p $PROTOCOL $PORT
			fi
		fi
	fi

	EXTERNALIP=$(wget -4qO- "http://whatismyip.akamai.com/")
	if [[ "$IP" != "$EXTERNALIP" ]]; then
echo ""
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #        AUTOSCRIPT CREATED BY â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€         #    "
echo -e "${RED} #      -----------About Us------------         #    "
echo -e "${RED} #    OS  DEBIAN 7-8-9  OS  UBUNTU 14-16-18     #    "
echo -e "${RED} #       Truemoney Wallet : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€        #    "
echo -e "${RED} #               { VPN / SSH }                  #    "
echo -e "${RED} #         BY : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€               #    "
echo -e "${RED} #    FB : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} à¹„à¸­à¸žà¸µà¹€à¸‹à¸´à¸Ÿ: $IP "
echo -e "${NC} "
		echo "à¸•à¸£à¸§à¸ˆà¸žà¸šà¹€à¸šà¸·à¹‰à¸­à¸‡à¸«à¸¥à¸±à¸‡à¹€à¸‹à¸´à¸Ÿà¹€à¸§à¸­à¸£à¹Œà¸‚à¸­à¸‡à¸„à¸¸à¸“à¹€à¸›à¹‡à¸™ Network Addrsss Translation (NAT)"
		echo "NAT à¸„à¸·à¸­à¸­à¸°à¹„à¸£ ? : http://www.greatinfonet.co.th/15396685/nat"
		echo ""
		echo "à¸«à¸²à¸à¹€à¸‹à¸´à¸Ÿà¹€à¸§à¸­à¸£à¹Œà¸‚à¸­à¸‡à¸„à¸¸à¸“à¹€à¸›à¹‡à¸™ (NAT) à¸„à¸¸à¸“à¸ˆà¸³à¹€à¸›à¹‡à¸™à¸•à¹‰à¸­à¸‡à¸£à¸°à¸šà¸¸ IP à¸ à¸²à¸¢à¸™à¸­à¸à¸‚à¸­à¸‡à¸„à¸¸à¸“"
		echo "à¸«à¸²à¸à¹„à¸¡à¹ˆà¹ƒà¸Šà¹ˆ à¸à¸£à¸¸à¸“à¸²à¹€à¸§à¹‰à¸™à¸§à¹ˆà¸²à¸‡à¹„à¸§à¹‰"
		echo "à¸«à¸£à¸·à¸­à¸«à¸²à¸à¹„à¸¡à¹ˆà¹à¸™à¹ˆà¹ƒà¸ˆ à¸à¸£à¸¸à¸“à¸²à¹€à¸›à¸´à¸”à¸”à¸¹à¸¥à¸´à¹‰à¸‡à¸„à¹Œà¸”à¹‰à¸²à¸™à¸šà¸™à¹€à¸žà¸·à¹ˆà¸­à¸¨à¸¶à¸à¸©à¸²à¸‚à¹‰à¸­à¸¡à¸¹à¸¥à¹€à¸à¸µà¹ˆà¸¢à¸§à¸à¸±à¸š (NAT)"
		echo ""
		read -p "External IP: " -e USEREXTERNALIP
		if [[ "$USEREXTERNALIP" != "" ]]; then
			IP=$USEREXTERNALIP
		fi
	fi

echo "client
dev tun
proto $PROTOCOL
sndbuf 0
rcvbuf 0
remote $IP:$Port$@cf.shopee.co.th
http-proxy $IP $PROXY
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
auth SHA512
cipher AES-256-CBC
comp-lzo
setenv opt block-outside-dns
key-direction 1
verb 3" > /etc/openvpn/client-common.txt

	case $OPENVPNSYSTEM in
		2)
		echo "auth-user-pass" >> /etc/openvpn/client-common.txt
		;;
	esac

	cd
	apt-get -y install nginx
	cat > /etc/nginx/nginx.conf <<END
user www-data;
worker_processes 2;
pid /var/run/nginx.pid;
events {
	multi_accept on;
        worker_connections 1024;
}
http {
	autoindex on;
        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;
        server_tokens off;
        include /etc/nginx/mime.types;
        default_type application/octet-stream;
        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;
        client_max_body_size 32M;
	client_header_buffer_size 8m;
	large_client_header_buffers 8 8m;
	fastcgi_buffer_size 8m;
	fastcgi_buffers 8 8m;
	fastcgi_read_timeout 600;
        include /etc/nginx/conf.d/*.conf;
}
END
	mkdir -p /home/vps/public_html
	echo "<pre>by phutthasit2530 | phutthasit2530</pre>" > /home/vps/public_html/index.html
	echo "<?phpinfo(); ?>" > /home/vps/public_html/info.php
	args='$args'
	uri='$uri'
	document_root='$document_root'
	fastcgi_script_name='$fastcgi_script_name'
	cat > /etc/nginx/conf.d/vps.conf <<END
server {
    listen       85;
    server_name  127.0.0.1 localhost;
    access_log /var/log/nginx/vps-access.log;
    error_log /var/log/nginx/vps-error.log error;
    root   /home/vps/public_html;
    location / {
        index  index.html index.htm index.php;
	try_files $uri $uri/ /index.php?$args;
    }
    location ~ \.php$ {
        include /etc/nginx/fastcgi_params;
        fastcgi_pass  127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
END

	if [[ "$VERSION_ID" = 'VERSION_ID="7"' || "$VERSION_ID" = 'VERSION_ID="8"' || "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
		if [[ -e /etc/squid3/squid.conf ]]; then
			apt-get -y remove --purge squid3
		fi

		apt-get -y install squid3
		cat > /etc/squid3/squid.conf <<END
http_port $PROXY
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx-xxxxxxxxx/255.255.255.255
http_access allow SSH
http_access allow localnet
http_access allow localhost
http_access deny all
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
END
		IP2="s/xxxxxxxxx/$IP/g";
		sed -i $IP2 /etc/squid3/squid.conf;
		if [[ "$VERSION_ID" = 'VERSION_ID="14.04"' ]]; then
			service squid3 restart
			/etc/init.d/openvpn restart
			/etc/init.d/nginx restart
		else
			/etc/init.d/squid3 restart
			/etc/init.d/openvpn restart
			/etc/init.d/nginx restart
		fi

	elif [[ "$VERSION_ID" = 'VERSION_ID="11"' || "$VERSION_ID" = 'VERSION_ID="16.04"' || "$VERSION_ID" = 'VERSION_ID="18.04"' ]]; then
		if [[ -e /etc/squid/squid.conf ]]; then
			apt-get -y remove --purge squid
		fi

		apt-get -y install squid
		cat > /etc/squid/squid.conf <<END
http_port $PROXY
acl localhost src 127.0.0.1/32 ::1
acl to_localhost dst 127.0.0.0/8 0.0.0.0/32 ::1
acl localnet src 10.0.0.0/8
acl localnet src 172.16.0.0/12
acl localnet src 192.168.0.0/16
acl SSL_ports port 443
acl Safe_ports port 80
acl Safe_ports port 21
acl Safe_ports port 443
acl Safe_ports port 70
acl Safe_ports port 210
acl Safe_ports port 1025-65535
acl Safe_ports port 280
acl Safe_ports port 488
acl Safe_ports port 591
acl Safe_ports port 777
acl CONNECT method CONNECT
acl SSH dst xxxxxxxxx-xxxxxxxxx/255.255.255.255
http_access allow SSH
http_access allow localnet
http_access allow localhost
http_access deny all
refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320
END
		IP2="s/xxxxxxxxx/$IP/g";
		sed -i $IP2 /etc/squid/squid.conf;
		/etc/init.d/squid restart
		/etc/init.d/openvpn restart
		/etc/init.d/nginx restart
	fi

fi


echo ""
echo -e "\033[0;32m { DOWNLOAD MENU SCRIPT }${NC} "
echo ""
	cd /usr/local/bin
wget -q -O m "https://raw.githubusercontent.com/phutthasit2530/openvpnauto/master/Menu"
chmod +x /usr/local/bin/m
	wget -O /usr/local/bin/Auto-Delete-Client "https://raw.githubusercontent.com/phutthasit2530/PURE/master/Auto-Delete-Client"
	chmod +x /usr/local/bin/Auto-Delete-Client 
	apt-get -y install vnstat
	cd /etc/openvpn/easy-rsa/
	./easyrsa build-client-full $CLIENT nopass
	newclient "$CLIENT"
	cp /root/$CLIENT.ovpn /home/vps/public_html/
	rm -f /root/$CLIENT.ovpn
	case $OPENVPNSYSTEM in
		2)
		useradd $Usernames
		echo -e "$Passwords\n$Passwords\n"|passwd $Usernames &> /dev/null
		;;
	esac
	
	
	clear
echo ""
echo ""
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${RED} #        AUTOSCRIPT CREATED BY â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€         #    "
echo -e "${RED} #      -----------About Us------------         #    "
echo -e "${RED} #    OS  DEBIAN 7-8-9  OS  UBUNTU 14-16-18     #    "
echo -e "${RED} #       Truemoney Wallet : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€        #    "
echo -e "${RED} #               { VPN / SSH }                  #    "
echo -e "${RED} #         BY : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€               #    "
echo -e "${RED} #    FB : â”€â”â•à¤¹àº«àº¡àº²àºªàºµà»‰à»àº¡à»ˆàº¡àº·àº‡à¤¹â•â”â”€       #    "
echo -e "${RED} =============== OS-32 & 64-bit =================    "
echo -e "${GREEN} à¹„à¸­à¸žà¸µà¹€à¸‹à¸´à¸Ÿ: $IP "
echo -e "${NC} "
	echo "OpenVPN, Squid Proxy, Nginx .....Install finish."
	echo "IP Server : $IP"
	echo "Port Server : $PORT"
	if [[ "$PROTOCOL" = 'udp' ]]; then
		echo "Protocal : UDP"
	elif [[ "$PROTOCOL" = 'tcp' ]]; then
		echo "Protocal : TCP"
	fi
	echo "Port Nginx : 85"
	echo "IP Proxy : $IP"
	echo "Port Proxy : $PROXY"
	echo ""
	case $OPENVPNSYSTEM in
		1)
		echo "Download My Config : http://$IP:85/$CLIENT.ovpn"
		;;
		2)
		echo "Download Config : http://$IP:85/$CLIENT.ovpn"
		echo ""
		echo "Your Username : $Usernames"
		echo "Your Password : $Passwords"
		echo "Expire : Never"
		;;
		3)
		echo "Download Config : http://$IP:85/$CLIENT.ovpn"
		;;
	esac
	echo ""
	echo "===================================================================="
	echo -e "à¸•à¸´à¸”à¸•à¸±à¹‰à¸‡à¸ªà¸³à¹€à¸£à¹‡à¸ˆ... à¸à¸£à¸¸à¸“à¸²à¸žà¸´à¸¡à¸žà¹Œà¸„à¸³à¸ªà¸±à¹ˆà¸‡${YELLOW} m ${NC} à¹€à¸žà¸·à¹ˆà¸­à¹„à¸›à¸¢à¸±à¸‡à¸‚à¸±à¹‰à¸™à¸•à¸­à¸™à¸–à¸±à¸”à¹„à¸›"
	echo "===================================================================="
	echo ""
	exit

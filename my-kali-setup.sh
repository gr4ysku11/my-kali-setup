#!/bin/bash

# update system
sudo apt update && sudo apt -y upgrade

# autorecon reqs
sudo apt install -y seclists curl dnsrecon enum4linux feroxbuster gobuster impacket-scripts nbtscan nikto nmap onesixtyone oscanner redis-tools smbclient smbmap snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf virtualenv

# virtual python environment
virtualenv -p $(which python) ~/.pyenv/python3

# install autorecon
source ~/.pyenv/python3/bin/activate
pip install git+https://github.com/Tib3rius/AutoRecon.git

# install impacket
pip install impacket

deactivate

# install vscodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

sudo apt update && sudo apt install codium

# add microsoft gallery for extensions in vscodium
sudo sed -i "s/open-vsx.org\/vscode\/gallery/marketplace.visualstudio.com\/_apis\/public\/gallery/" /usr/share/codium/resources/app/product.json
sudo sed -i "s/open-vsx.org\/vscode\/item/marketplace.visualstudio.com\/items/" /usr/share/codium/resources/app/product.json

# install my favorite extensions
codium --install-extension vscodevim.vim && codium --install-extension ms-python.python && \
	codium --install-extension dendron.dendron-paste-image && codium --install-extension ms-vscode.cpptools

# install other packages
sudo apt install -y \
	keepassxc \
	bloodhound \
	neo4j \
	shutter \
  	chromium \
	xrdp

# enable rdp server
sudo systemctl enable xrdp
sudo systemctl start xrdp

echo "******CHANGE PASSWORD******"
passwd kali

$ip = $(hostname -I)
echo "xfreerdp /u:kali /v:$ip/dynamic-resolution"
echo "Press any key to continue..."
read -s -n 1

# logout for rdp access
sudo systemctl restart display-manager

# my random notes
#
# autorecon for quicker scanning
# autorecon -o . --exclude-tags=long --port-scans=all-tcp-ports <target>
#
# resolution resize for qemu vm
# xrandr --output Virtual-1 --auto
# 
# convert vmware image to ova
# ovftool kali.vmx kali.ova
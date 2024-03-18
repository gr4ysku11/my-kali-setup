#!/bin/bash

# update system
sudo apt update && apt -y upgrade

# autorecon reqs
sudo apt install seclists curl dnsrecon enum4linux feroxbuster gobuster impacket-scripts nbtscan nikto nmap onesixtyone oscanner redis-tools smbclient smbmap snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf virtualenv

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
apt install -y \
	keepassxc \
	bloodhound \
	neo4j \
	shutter \
  chromium

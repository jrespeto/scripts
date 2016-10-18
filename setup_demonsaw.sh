#!/bin/bash

# Script for downloading and updating demonsaw

sudo mkdir /opt/scripts
sudo cat <<EOF>/opt/scripts/latest_demonsaw.sh 
#!/bin/bash

# this download the latest verions from stable

cd /opt
echo "Getting Latest Demonsaw"
rm -f demonsaw_debian_64.tar.gz
mkdir -m 775 demonsaw
wget -O  demonsaw_debian_64.tar.gz "http://demonsaw.com/download/3.1.0/demonsaw_debian_64.tar.gz"
tar -xzf demonsaw_debian_64.tar.gz -C demonsaw
chgrp -R staff demonsow
rm -f demonsaw_debian_64.tar.gz

EOF

sudo chmod +x /opt/scripts/latest_demonsaw.sh


# Icons for demonsaw

sudo cat <<EOF>/usr/share/applications/demonsaw.desktop 
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=/opt/demonsaw/demonsaw
Name=Demonsaw
Icon=demonsaw
Categories=Internet;Network;WebBrowser;
Actions=NewWindow

EOF

sudo chmod +x /usr/share/applications/demonsaw.desktop

# Download demonsaw 

sudo /opt/scripts/latest_demonsaw.sh


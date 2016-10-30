#!/bin/bash

# Script for downloading and updating demonsaw

mkdir -m 775 /opt/demonsaw
mv /opt/scripts/demonsaw.png /opt/demonsaw/
sudo cat <<EOF>/opt/scripts/latest_demonsaw.sh
#!/bin/bash

# this download the latest verions from stable

cd /opt
echo "Getting Latest Demonsaw"
rm -f /opt/demonsaw_debian_64.tar.gz
wget -O /opt/demonsaw_debian_64.tar.gz "http://demonsaw.com/download/latest/demonsaw_debian_64.tar.gz"
tar -xzf /opt/demonsaw_debian_64.tar.gz -C /opt/demonsaw
chgrp -R staff /opt/demonsaw
rm -f /opt/demonsaw_debian_64.tar.gz

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
Icon=/opt/demonsaw/demonsaw.png
Categories=Internet;Network;WebBrowser;
Actions=NewWindow

EOF

sudo chmod +x /usr/share/applications/demonsaw.desktop

# Download demonsaw 

sudo /opt/scripts/latest_demonsaw.sh


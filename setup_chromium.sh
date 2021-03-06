#!/bin/bash

# Script for making a downloader script for setup and updating chromium
# Also setups an icon for ubuntu.  

sudo mkdir /opt/scripts
sudo cat <<EOF>/opt/scripts/latest_chrome.sh
#!/bin/bash
cd /opt
rm -rf /opt/chrome-linux
wget -O chrome-linux.zip https://download-chromium.appspot.com/dl/Linux_x64?type=snapshots
unzip /opt/chrome-linux.zip
rm -f /opt/chrome-linux.zip

chgrp staff /opt/chrome-linux -R
chmod 775 /opt/chrome-linux -R
cp /opt/chrome-linux/chrome_sandbox /usr/local/sbin/chrome-devel-sandbox
chown root:root /usr/local/sbin/chrome-devel-sandbox
chmod 4755 /usr/local/sbin/chrome-devel-sandbox

chown root:root /opt/chrome-linux/chrome_sandbox
chmod 4755 /opt/chrome-linux/chrome_sandbox
cd /opt/chrome-linux
ln -s /opt/chrome-linux/chrome_sandbox /opt/chrome-linux/chrome-sandbox

EOF

sudo chmod 755 /opt/scripts/latest_chrome.sh

# Script to run chromium

sudo cat <<EOF>/opt/scripts/run_chrome.sh
#!/bin/bash
export GOOGLE_API_KEY="no"
export GOOGLE_DEFAULT_CLIENT_ID="no"
export GOOGLE_DEFAULT_CLIENT_SECRET="no"
export CHROME_DEVEL_SANDBOX=

/opt/chrome-linux/chrome
sudo chmod 755 /opt/scripts/run_chrome.sh
EOF

# Icon for chromium

sudo cat <<EOF>/usr/share/applications/chromium.desktop
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Categories=Network;WebBrowser;
Icon[en_US]=/opt/chrome-linux/product_logo_48.png
Name[en_US]=Chromium
Exec=/opt/scripts/run_chrome.sh
Name=Chromium
Icon=/opt/chrome-linux/product_logo_48.png
TargetEnvironment=Unity

EOF
sudo chmod 755 /usr/share/applications/chromium.desktop

# Download chromium 

sudo /opt/scripts/latest_chrome.sh

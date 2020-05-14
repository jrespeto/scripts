#!/bin/bash

# Script for downloading and updating firefox

sudo mkdir /opt/scripts
sudo cat <<EOF>/opt/scripts/latest_firefox.sh 
#!/bin/bash

# this download the latest verions from beta and stable

cd /opt
echo "Getting Latest Firefox-beta"
rm -f FirefoxBetaSetup.tar.bz2
rm -rf firefox-beta
mkdir -m 775 firefox-beta
wget -O FirefoxBetaSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-beta-latest&os=linux64&lang=en-US"
tar -xjf FirefoxBetaSetup.tar.bz2 -C firefox-beta --strip-components=1
chgrp -R staff firefox-beta
rm -f FirefoxBetaSetup.tar.bz2


echo "Getting Latest Firefox-stable"
rm -f FirefoxSetup.tar.bz2
rm -rf firefox-stable
mkdir -m 775 firefox-stable
wget -O FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
tar -xjf FirefoxSetup.tar.bz2 -C firefox-stable --strip-components=1
chgrp -R staff firefox-stable
rm -f FirefoxSetup.tar.bz2


EOF

sudo chmod +x /opt/scripts/latest_firefox.sh


# Icons for firefox and firefox-beta

sudo cat <<EOF>/usr/share/applications/firefox.desktop 
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=/opt/firefox-stable/firefox -no-remote -P
Name=Firefox
Icon=firefox
Categories=Internet
Actions=NewWindow;NewPrivateWindow;

[Desktop Action NewWindow]
Name=Open a New Window
Exec=/opt/firefox-stable/firefox -new-window 
OnlyShowIn=Unity;

[Desktop Action NewPrivateWindow]
Name=Open a New Private Window
Exec=/opt/firefox-stable/firefox -private-window -P -no-remote 
OnlyShowIn=Unity;

EOF

sudo cat <<EOF>/usr/share/applications/firefox-beta.desktop 
#!/usr/bin/env xdg-open

[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=/opt/firefox-beta/firefox -no-remote -P
Name=Firefox-beta
Icon=firefox
Categories=Internet
Actions=NewWindow;NewPrivateWindow;

[Desktop Action NewWindow]
Name=Open a New Window
Exec=/opt/firefox-beta/firefox -new-window 
OnlyShowIn=Unity;

[Desktop Action NewPrivateWindow]
Name=Open a New Private Window
Exec=/opt/firefox-beta/firefox -private-window -P -no-remote 
OnlyShowIn=Unity;

EOF
sudo chmod +x /usr/share/applications/firefox.desktop
sudo chmod +x /usr/share/applications/firefox-beta.desktop

# Download firefox 

sudo /opt/scripts/latest_firefox.sh

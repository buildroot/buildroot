#!/bin/bash

#--------------------
# YIO updater script
# the update URL is written to /usr/bin/updateURL from the remote app
#--------------------
url=`cat /usr/bin/updateURL`


#--------------------
# 1. Show the update screen
#--------------------
fbv -d 1 /usr/bin/yio-remote/images/update.png
echo "Update image loaded" > /usr/bin/update.log


#--------------------
# 2. Create temp location
#--------------------
mkdir -p /usr/bin/yio-tmp
echo "Temp dir created" >> /usr/bin/update.log


#--------------------
# 3. Download the URL that is given to the bash script and extract the zip file
#--------------------
curl -SL $url --output /yioremote.zip
sleep 4
unzip /yioremote.zip -d /usr/bin/yio-tmp
echo "Update downloaded and unzipped" >> /usr/bin/update.log


#--------------------
# 4. Give executable permissions to all .sh files
#--------------------
find /usr/bin/yio-tmp -type f -name "*.sh" -exec chmod 775 {} +
chmod +x /usr/bin/yio-tmp/remote
echo "File attributes set" >> /usr/bin/update.log


#--------------------
# 5. Remove previous backups (should not be needed, unless this scripts fails somewhere, therefore not yet implemented)
#--------------------
rm -rf /usr/bin/yio-remote-backup
echo "Old backup removed" >> /usr/bin/update.log


#--------------------
# 6. Make a backup of the /usr/bin/remote folder (if not already exist, maybe add timestamp to folder)
#--------------------
mv /usr/bin/yio-remote /usr/bin/yio-remote-backup
echo "New backup created" >> /usr/bin/update.log


#--------------------
# 7. Rename the update folder to /usr/bin/yio-remote
#--------------------
mv /usr/bin/yio-tmp /usr/bin/yio-remote
echo "Update copied" >> /usr/bin/update.log
sleep 2

#--------------------
# 8. Launch a script with remaning commands
# this is used to copy/move files and execute commands with each update
#--------------------
/usr/bin/yio-remote/after-update.sh
sleep 2


#--------------------
# 9. Launch the remote app with the launcher bash script
#--------------------
echo "Launching app" >> /usr/bin/update.log
/usr/bin/yio-remote/app-launch.sh &

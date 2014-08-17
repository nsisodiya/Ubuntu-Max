#!/bin/bash

# This Script will run inside Chroot Environment

echo "Now We are into Chroot of RootFS of Live ISO, We will make some changes"

echo ""
echo " ================ `arch`======================= "
echo ""
echo "Installing Additional packages"

### Taking Backup of Source.list
mv /etc/apt/sources.list /tmp/sources.list.backup
mv /tmp/sources.list /etc/apt/sources.list
apt-get update
apt-get install -y vlc

### Restoring sources.list
mv /tmp/sources.list.backup /etc/apt/sources.list


cd /tmp
echo "================================"
echo "We are into Chroot of New RootFS"
#./Modify_SourceList.sh

#./Add_Remove_Packages.sh
#./Apply_Gconf_Setting.sh
#./"Apply Theme Changes.sh"

#mv /etc/apt/sources.list.backup /etc/apt/sources.list

function ChangeUbiquity(){
  echo "==============  ChangeUbiquity ========"
  sed -i "s/LinuxMint/$New_Distro_Name/" /usr/lib/ubiquity/plugins/ubi-prepare.py
  sed -i "s/LinuxMint/$New_Distro_Name/" /usr/lib/ubiquity/plugins/ubi-language.py
  sed -i "s/Linux Mint/$New_Distro_Name/"  /usr/lib/ubiquity/ubiquity/frontend/kde_components/PartitionBar.py
  sed -i "s/LinuxMint/$New_Distro_Name/"  /usr/lib/ubiquity/ubiquity/frontend/kde_components/testing/partitionbar.py
  sed -i "s/Linux Mint/$New_Distro_Name/" /usr/lib/ubiquity/ubiquity/misc.py
  sed -i "s/LinuxMint/$New_Distro_Name/" /usr/lib/ubiquity/ubiquity/frontend/kde_ui.py
  
  sed -i "s/LinuxMint/$New_Distro_Name/" /usr/share/ubiquity/qt/app.ui
  sed -i "s/LinuxMint/$New_Distro_Name/" /usr/share/ubiquity/qt/stepPartAuto.ui

}

ChangeUbiquity

exit 0


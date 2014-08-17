Ubuntu_ISO_Path="/home/narendra/All/MyData/MyWork-New/Ubuntu-Max/ubuntu-12.10-desktop-i386.iso"
ARCH="i386"
New_Distro_Name="Ubuntu-Max"
debug=true
REMASTER_DIR="~/tmp"

# Variables
VERSION="1.0"
BASE="Ubuntu 12.10"

# Get working directory
WORKDIR=$(pwd)

TARGET="$WORKDIR/$New_Distro_Name-$VERSION-$ARCH.iso"
Description=$New_Distro_Name-$VERSION

REMASTER_DIR="$WORKDIR/temp"

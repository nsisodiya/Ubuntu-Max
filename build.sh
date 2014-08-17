#!/bin/bash

echo "======================================"
echo "#######  Creating $New_Distro_Name ########"
echo "======================================"
echo ""
StartTime=`date +%s`



####  Note -- I have created SchoolOS script. Now I am 
###   Modifying again. current Scripts are inspired from https://bitbucket.org/ariosproject/build-system/src/c180a2f2316c/Build/abuild.sh?at=master  And
###   My Project - http://code.google.com/p/schoolos/source/browse/trunk/Ubuntu/GetRoot.sh


. ./other/Extract_ISO_RootFS.sh

# Extract and Compress Initrd Change
#./Change_Initrd.sh

#  Changing Logos and otherThinsg in ISO
./Rebrand_ISO.sh

cp -v ./other/Add_Software.chroot.sh /tmp/
cp -v ./other/sources.list /tmp/
uck-remaster-chroot-rootfs "$REMASTER_DIR" /tmp/Add_Software.chroot.sh "--$ARCH"
#uck-remaster-chroot-rootfs "$REMASTER_DIR"

if [ $? != 0 ]; then
        echo 'Install.sh returned an error. Aborting.'
        echo 'Removing temporary files...'
        # Clean up previous build
        if [ $debug == true ]; then echo '$ uck-remaster-clean "$REMASTER_DIR"'; fi
        uck-remaster-clean "$REMASTER_DIR"
        
        #if [ $debug == true ]; then echo '$ rm -R $REMASTER_DIR &>/dev/null'; fi
        #rm -R $REMASTER_DIR &>/dev/null
        exit 1
fi


# Regenerate manifest and compress filesystem
if [ $debug == true ]; then echo '$ uck-remaster-pack-rootfs "$REMASTER_DIR"'; fi
uck-remaster-pack-rootfs "$REMASTER_DIR"

# Create the ISO image
if [ $debug == true ]; then echo '$ uck-remaster-pack-iso "$TARGET" "$REMASTER_DIR" --description="Description"'; fi
uck-remaster-pack-iso "$TARGET" "$REMASTER_DIR" --description="$Description"

# md5sum the image
if [ $debug == true ]; then echo '$ md5sum "$TARGET" > "$TARGET".md5'; fi
md5sum "$TARGET" > "$TARGET".md5



# Clean up
if [ $debug == true ]; then echo '$ uck-remaster-clean "$REMASTER_DIR"'; fi
uck-remaster-clean "$REMASTER_DIR"
#if [ $debug == true ]; then echo '$ rm -R $REMASTER_DIR &>/dev/null'; fi
#rm -R $REMASTER_DIR &>/dev/null

EndTime=`date +%s`
let DIFF=(EndTime-StartTime)/60

#date +%d-%m-%Y
echo "Build for $New_Distro_Name $VERSION ($ARCH) has finished!"
echo " --------  Time Taken = $DIFF Minutes !    --------------"
echo "You will find your new $New_Distro_Name build at $TARGET"
echo ""

exit 0

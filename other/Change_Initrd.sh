#!/bin/bash

. config.sh
CurrDir="$PWD"

echo "##### UnPack ###########"

cd $REMASTER_DIR
mkdir -p remaster-initrd/
cd ./remaster-initrd/
echo "Current Path is = $PWD"

#file ../remaster-iso/casper/initrd.lz | grep gzip
#if [ $? -eq "0" ]; then
#
#else
#
#fi

gunzip -dc ../remaster-iso/casper/initrd.lz | cpio -imd --no-absolute-filenames

echo "################  Change Files ###########"

sed -i "s/Linux Mint/$New_Distro_Name/" ./lib/plymouth/themes/text.plymouth


echo "########### Packing  ######"

#cp -v "../remaster-iso/casper/initrd.lz" "../remaster-iso/casper/initrd.lz.old"
find . | cpio --quiet --dereference -o -H newc | lzma -7 > "../remaster-iso/casper/initrd.lz"

#ls -l ../remaster-iso/casper/initrd.*
################ Deleting Files ###########

rm -rf $REMASTER_DIR/remaster-initrd/*

cd $CurrDir

#cp -r "$REMASTER_DIR"/remaster-root/lib/plymouth/themes "$REMASTER_DIR"/remaster-initrd/lib/plymouth/
#sudo rm "$REMASTER_DIR"/remaster-initrd/lib/plymouth/themes/default.plymouth
#sudo ln -s '/lib/plymouth/themes/AriOS/AriOS.plymouth' "$REMASTER_DIR"/remaster-initrd/lib/plymouth/themes/default.plymouth
#rm -r "$REMASTER_DIR"/remaster-initrd/lib/plymouth/themes/ubuntu-logo


#uck-remaster-pack-initrd
exit 0

# Rebranding ISO contents
if [ $debug == true ]; then echo '# Rebranding ISO contents'; fi
cp -t "$REMASTER_DIR"/remaster-iso/isolinux "$WORKDIR"/rsrc/access.pcx "$WORKDIR"/rsrc/blank.pcx "$WORKDIR"/rsrc/splash.pcx "$WORKDIR"/rsrc/gfxboot.cfg
cd "$REMASTER_DIR"/remaster-iso/
sed -i 's/DISTRIB_DESCRIPTION="Ubuntu 12.04"/DISTRIB_DESCRIPTION="AriOS"/' boot/grub/loopback.cfg
sed -i "s/Ubuntu/AriOS/" boot/grub/loopback.cfg
# rm -r *.exe autorun.inf README.diskdefines pics ubuntu 
echo "AriOS $VERSION - $ARCH" > .disk/info
echo "http://arioslinux.org/news/2012/09/arios-4-0-final-is-out/" > .disk/release_notes_url
mv preseed/ubuntu.seed preseed/arios.seed 
sed -i "s/12.04/$VERSION/" isolinux/f1.txt isolinux/*.hlp
sed -i "s/Ubuntu/AriOS/" isolinux/*.hlp isolinux/txt.cfg
sed -i "s/Ubuntu/AriOS/" isolinux/f1.txt isolinux/f2.txt isolinux/f9.txt isolinux/f10.txt
sed -i "s/ Ubuntu/ AriOS/" isolinux/*.hlp isolinux/f9.txt 
sed -i "s/UBUNTU/AriOS/" isolinux/f2.txt
sed -i "s/20110427.1/`date +%Y%m%d`/" isolinux/f1.txt isolinux/*.hlp
sed -i "s/ubuntu.com/arioslinux.org/" isolinux/*.hlp isolinux/f2.txt isolinux/f9.txt
sed -i "s/Copyright/Copyleft/" isolinux/*.hlp isolinux/f10.txt
sed -i "s/ Canonical Ltd./ The AriOS team/" isolinux/*.hlp isolinux/f10.txt
sed -i "s/Debian/&, Ubuntu/" isolinux/f10.txt isolinux/*.hlp
sed -i "s/.org/&, www.ubuntu.com/" isolinux/f10.txt isolinux/*.hlp
sed -i "s/ubuntu.seed /arios.seed /" isolinux/txt.cfg boot/grub/loopback.cfg
sed -i "s/project./& Ubuntu is a registred trademark of Canonical Ltd./" isolinux/f10.txt
sed -i "s/Ubuntu /AriOS /g" isolinux/*.tr

. config.sh


function ChangeDiskLabel(){
  echo "OpenLX Linux 13 Release i386" > /home/vivek/tmp/remaster-iso/.disk/info
}

function ChangeMenuEntry(){

cat > $REMASTER_DIR/remaster-iso/boot/grub/loopback.cfg.new << EOL
menuentry "Install OpenLX Linux" {
	set gfxpayload=keep
	linux	/casper/vmlinuz  file=/cdrom/preseed/mint.seed boot=casper only-ubiquity iso-scan/filename=\${iso_path} quiet splash --
	initrd	/casper/initrd.lz
}
EOL

  cat $REMASTER_DIR/remaster-iso/boot/grub/loopback.cfg >> $REMASTER_DIR/remaster-iso/boot/grub/loopback.cfg.new

  mv $REMASTER_DIR/remaster-iso/boot/grub/loopback.cfg.new $REMASTER_DIR/remaster-iso/boot/grub/loopback.cfg

  sed -i "s/Linux Mint/OpenLX Linux/" $REMASTER_DIR/remaster-iso/boot/grub/loopback.cfg
  
  cp -v ./buildos/isolinux.cfg $REMASTER_DIR/remaster-iso/isolinux/isolinux.cfg
  
  cp -v ./buildos/splash.jpg $REMASTER_DIR/remaster-iso/isolinux/splash.jpg

}

ChangeDiskLabel
ChangeMenuEntry

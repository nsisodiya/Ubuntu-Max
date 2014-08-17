# Unpack initial RAM disk
if [ $debug == true ]; then echo '$ uck-remaster-unpack-initrd "$REMASTER_DIR"'; fi
uck-remaster-unpack-initrd "$REMASTER_DIR"


#copy default plymoth theme
cp -r "$REMASTER_DIR"/remaster-root/lib/plymouth/themes "$REMASTER_DIR"/remaster-initrd/lib/plymouth/
sudo rm "$REMASTER_DIR"/remaster-initrd/lib/plymouth/themes/default.plymouth
sudo ln -s '/lib/plymouth/themes/AriOS/AriOS.plymouth' "$REMASTER_DIR"/remaster-initrd/lib/plymouth/themes/default.plymouth
rm -r "$REMASTER_DIR"/remaster-initrd/lib/plymouth/themes/ubuntu-logo


# Compressing initial ram disk back
if [ $debug == true ]; then echo '$ uck-remaster-pack-initrd "$REMASTER_DIR"'; fi
uck-remaster-pack-initrd "$REMASTER_DIR"

#dpkg --get-selections | grep ubiquity | cut -f1 | while read p; do dpkg -L $p | while read i; do if [ -f "$i" ]; then cat "$i" | grep -i LinuxMint ; if [ $? -eq 0 ]; then echo " === File == $i"; fi fi done; done

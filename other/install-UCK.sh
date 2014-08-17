#!/bin/bash

echo "installing ubuntu development kit"

sudo add-apt-repository ppa:uck-team/uck-stable
sudo apt-get update
sudo apt-get install uck


#diff -uNr remaster-live-cd.sh.old remaster-live-cd.sh.new  > uck-resolv.conf.patch
#patch -p1 < ../uck-resolv.conf.patch

sudo mkdir -p /var/run/resolvconf
sudo cp /etc/resolv.conf /var/run/resolvconf/

exit 0

# Check if script is in the working directory or not
ls | grep build.sh &>/dev/null
if [ $? != 0 ]; then
        echo 'Error - Please run the script from its own directory! Aborting.'
        exit 1
fi

# Loading Configuration


echo "Loading Configuration .............."
. ./other/config.sh



# Check for root privileges
if [ `id -u` !=  0 ]; then
        echo 'You need to be root to run aBuild! Aborting.'
        exit 1
fi

# Check for necessary packages
dpkg -L uck &>/dev/null
if [ $? != 0 ]; then
        echo 'ERROR: Missing dependencies! Aborting.'
        echo 'aBuild requires Ubuntu Customization Kit but it is not installed.'
        echo 'You can do it with the following command:'
        echo 'sudo apt-get install uck'
        exit 1
fi


# Check for base iso
ls $Ubuntu_ISO_Path &>/dev/null
if [ $? != 0 ]; then
        echo "$Ubuntu_ISO_Path not found! please edit ./config.sh Aborting."
        exit 1;
fi


# Clean up previous build
if [ $debug == true ]; then echo '$ uck-remaster-clean "$REMASTER_DIR"'; fi
uck-remaster-clean "$REMASTER_DIR"

#if [ $debug == true ]; then echo '$ rm -R $REMASTER_DIR &>/dev/null'; fi
#rm -R $REMASTER_DIR &>/dev/null
#if [ $debug == true ]; then echo '$ mkdir -p $REMASTER_DIR &>/dev/null'; fi
#mkdir -p $REMASTER_DIR &>/dev/null
# @TODO BackNeed for .deb packages



# Extract the CD .iso contents
if [ $debug == true ]; then echo '$ uck-remaster-unpack-iso "$BASE_ISO" "$REMASTER_DIR"'; fi
uck-remaster-unpack-iso "$Ubuntu_ISO_Path" "$REMASTER_DIR"

# Extract the Desktop system
if [ $debug == true ]; then echo '$ uck-remaster-unpack-rootfs "$REMASTER_DIR"'; fi
uck-remaster-unpack-rootfs "$REMASTER_DIR"

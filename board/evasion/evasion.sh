SOURCE=/mnt/nfs
DESTINATION=/usr/metrological

mkdir -p $SOURCE
mkdir -p $DESTINATION/lib

udhcpc eth0

mount -t nfs -o nolock 192.168.1.203:/usr/src/nfs/nos $SOURCE

cp $SOURCE/usr/lib/libstdc++.so.6.0.21 $DESTINATION/lib/libstdc++.so.6
cp -r $SOURCE/etc/WPEFramework /etc/WPEFramework
cp -r $SOURCE/usr/lib/libWPE* /usr/lib/
cp -r $SOURCE/usr/lib/wpeframework/ /usr/lib/wpeframework
cp -r $SOURCE/usr/bin/WPE* /usr/bin
cp -r $SOURCE/usr/share/WPEFramework /usr/share/WPEFramework

export LD_LIBRARY_PATH=$DESTINATION/lib:$LD_LIBRARY_PATH



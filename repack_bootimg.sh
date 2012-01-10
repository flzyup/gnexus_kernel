#!/bin/sh
RAMV=$1
if [ "ZZ${RAMV}" == "ZZ" ]
then
	echo "No version specified"
	exit 1
else
	cd initramfs-${RAMV} || exit 1
	find . | cpio -o -H newc | gzip > ../new_initramfs.cpio.gz
	cd ..
	./mkbootimg --kernel omap/arch/arm/boot/zImage --ramdisk new_initramfs.cpio.gz -o ../public_html/galaxy_nexus/kernel-${RAMV}.img 

rm new_initramfs.cpio.gz

fi

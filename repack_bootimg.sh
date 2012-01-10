#!/bin/sh
for RAMV in 4.0.2 4.0.3-cm9
do
	cd initramfs-${RAMV}
	find . | cpio -o -H newc | gzip > ../new_initramfs.cpio.gz
	cd ..
	./mkbootimg --kernel omap/arch/arm/boot/zImage --ramdisk new_initramfs.cpio.gz -o ../public_html/galaxy_nexus/kernel-${RAMV}.img 
done


rm new_initramfs.cpio.gz

#!/bin/sh
RAMV=$1
RELV="`cat ../.version`-${RAMV}"
RELV="_FuguMod_$(date +%Y%m%d_r)${RELV}"
if [ "ZZ${RAMV}" == "ZZ" ]
then
	echo "No version specified"
	exit 1
else
	cd initramfs-${RAMV} || exit 1
	find . | cpio -o -H newc | gzip > ../new_initramfs.cpio.gz
	cd ..
	./mkbootimg --kernel ../arch/arm/boot/zImage --ramdisk new_initramfs.cpio.gz -o ../../public_html/galaxy_nexus/kernel${RELV}.img 
	sha256sum ../../public_html/galaxy_nexus/kernel${RELV}.img > ../../public_html/galaxy_nexus/kernel${RELV}.sha256sum

	cd cwm
	cp ../../../public_html/galaxy_nexus/kernel${RELV}.img boot.img
        zip -q -r ../../../public_html/galaxy_nexus/kernel${RELV}.zip boot.img META-INF || exit 1
        sha256sum ../../../public_html/galaxy_nexus/kernel${RELV}.zip > ../../../public_html/galaxy_nexus/kernel${RELV}.zip.sha256sum

	cd ..
	rm new_initramfs.cpio.gz cwm/boot.img

fi



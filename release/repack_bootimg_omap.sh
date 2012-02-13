#!/bin/sh
RAMV=$1
KVER=`cat ../.version`
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
	abootimg --create /ext_usb/kernel${RELV}.img -k ../arch/arm/boot/zImage -r new_initramfs.cpio.gz
	sha256sum /ext_usb//kernel${RELV}.img > /ext_usb/kernel${RELV}.sha256sum

	git tag -a r${KVER} -m r${KVER}

	cd cwm
	cp /ext_usb/kernel${RELV}.img boot.img
        zip -q -r /ext_usb/kernel${RELV}.zip boot.img META-INF || exit 1
        sha256sum /ext_usb/kernel${RELV}.zip > /ext_usb/kernel${RELV}.zip.sha256sum

	scp /ext_usb/kernel* faramir.eriador.org:public_html/galaxy_nexus/testing-${RAMV}/

	cd ..
	rm new_initramfs.cpio.gz cwm/boot.img /ext_usb/kernel*
	
fi


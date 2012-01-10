#!/bin/sh
cd initramfs-*
 find . | cpio -o -H newc | gzip > ../new_initramfs.cpio.gz
cd ..
./mkbootimg --cmdline 'console=ttyO2,115200n8 androidboot.console=ttyO2' --kernel omap/arch/arm/boot/zImage --ramdisk new_initramfs.cpio.gz -o kernel.img

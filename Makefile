# Initramfs build targets
initramfs:
	cd initfs/ && find . | cpio -o --format=newc > ../initramfs

runvm: 
	qemu-system-x86_64 -m 2048 -kernel vmlinuz -initrd initramfs -append console=ttyS0 -nographic

getsrc: 
	wget https://busybox.net/downloads/busybox-1.31.1.tar.bz2
	wget https://git.kernel.org/torvalds/t/linux-5.7-rc7.tar.gz
	tar xvf busybox-1.31.1.tar.bz2
	tar xvf linux-5.7-rc7.tar.gz

kernel:
	cd linux-5.7-rc7
	make menuconfig
	make -j4

bbox:
	cd busybox-1.31.1
	make menuconfig
	make -j4

clean:
	rm -rf vmlinuz $(KERNEL_DIRECTORY) $(KERNEL_ARCHIVE) $(BUSYBOX_DIRECTORY) \
		$(BUSYBOX_ARCHIVE)

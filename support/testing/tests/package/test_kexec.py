import os

import infra.basetest


class TestKexec(infra.basetest.BRTest):

    # A specific configuration is needed for using kexec:
    # - We use Aarch64 since it is well supported for kexec,
    # - A kernel config fragment enables all the kexec parts,
    # - The kernel Image is installed on target filesystem to be
    #   reloaded through kexec,
    # - We use a ext4 rootfs image exposed as a virtio storage (rather
    #   than cpio initrd). This avoids needing to install the initrd
    #   inside the rootfs.
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.15"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{}"
        BR2_LINUX_KERNEL_DTS_SUPPORT=y
        BR2_LINUX_KERNEL_CUSTOM_DTS_PATH="{}"
        BR2_LINUX_KERNEL_INSTALL_TARGET=y
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_KEXEC=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
            infra.filepath("tests/package/test_kexec/linux-kexec.fragment"),
            infra.filepath("tests/package/test_kexec/qemu-aarch64-virt-5.2-machine.dts")
        )

    def test_run(self):
        hda = os.path.join(self.builddir, "images", "rootfs.ext4")
        kern = os.path.join(self.builddir, "images", "Image")
        dtb = os.path.join(self.builddir, "images", "qemu-aarch64-virt-5.2-machine.dtb")
        # Notes:
        # Sufficient memory is needed to load the kernel: having at
        # least 512MB works. kexec could silently fail if not enough
        # memory is present. KASLR needs to be disabled for the test:
        # we pass "nokaslr" to kernel bootargs, and also pass a custom
        # devicetree to qemu virt machine. This devicetree is based on
        # qemu aarch64 5.2 dts with kaslr-seed set 0.
        # With newer qemu >= 7.0 we can disable KASLR from the qemu
        # command line using "dtb-kaslr-seed=off".
        bootargs = ["root=/dev/vda console=ttyAMA0 nokaslr"]
        qemu_opts = ["-M", "virt", "-dtb", dtb, "-cpu", "cortex-a57", "-m", "512M",
                     "-drive", f"file={hda},if=virtio,format=raw"]
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=bootargs,
                           options=qemu_opts)
        self.emulator.login()

        # Test the program can execute
        self.assertRunOk("kexec --version")

        # Check the kexec kernel is NOT loaded:
        self.assertRunOk("test \"$(cat /sys/kernel/kexec_loaded)\" -eq 0")

        # Load the Kernel:
        # "--append br-test" adds a dummy kernel args we'll be able to
        # check in the second executed kernel.
        # We use the dtb image from /sys/firmware/fdt (since we don't
        # have the dtb file in the system)
        self.assertRunOk("kexec -d -l --dtb=/sys/firmware/fdt --reuse-cmdline --serial=ttyAMA0 --append=br-test /boot/Image")

        # Check the kexec kernel IS loaded:
        self.assertRunOk("test \"$(cat /sys/kernel/kexec_loaded)\" -eq 1")

        # Create a marker file in tmpfs which is supposed to disappear
        # after kexec kernel restart.
        self.assertRunOk("touch /dev/shm/br-kexec-marker")

        # Execute the loaded kernel (i.e perform a kexec reboot)
        # qemu.sendline() is used here because no exit code nor
        # program return is expected, since kexec is like a
        # reboot. The login is expected to be reached after the
        # command is issued.
        self.emulator.qemu.sendline("kexec -d -e")

        # Wait for the login, and log again
        self.emulator.login()

        # Check the "br-test" dummy kernel arg is present
        self.assertRunOk("grep br-test /proc/cmdline")

        # Check the test marker file is no longer here
        self.assertRunOk("test ! -e /dev/shm/br-kexec-marker")

        # After restart, the kernel is not supposed to have a kexec
        # loaded image:
        self.assertRunOk("test \"$(cat /sys/kernel/kexec_loaded)\" -eq 0")

import os

import infra.basetest


class TestBubblewrap(infra.basetest.BRTest):
    # Bubblewrap uses mount_setattr(2) introduced in Kernel 5.12:
    # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=2a1867219c7b27f928e2545782b86daaf9ad50bd
    # The Buildroot prebuilt Kernel is 5.10. To avoid testing
    # Bubblewrap with its fallback code, we build a newer kernel.
    # https://github.com/containers/bubblewrap/blob/v0.13.0/bind-mount.c#L27-L31
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.53"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_BUBBLEWRAP=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        disk = os.path.join(self.builddir, "images", "rootfs.ext4")
        kern = os.path.join(self.builddir, "images", "Image")
        bootargs = ["root=/dev/vda"]
        qemu_opts = ["-M", "virt", "-cpu", "cortex-a57", "-m", "512M",
                     "-drive", f"file={disk},if=virtio,format=raw"]
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=bootargs,
                           options=qemu_opts)
        self.emulator.login()

        # Check the program can execute
        self.assertRunOk("bwrap --version")

        # We set an arbitrary message used as test data.
        msg = "Hello Buildroot!"

        # We create three files to test the sandbox functionality.
        # One fully hidden to the sandbox, one passed as read-only and
        # one passed as fully read-write.
        dirs = ["hidden", "read-only", "read-write"]
        for d in dirs:
            self.assertRunOk(f"mkdir -p /mnt/{d}")
            self.assertRunOk(f"echo {d} > /mnt/{d}/file.txt")

        # We start the sandbox.
        cmd = [
            "bwrap",
            "--ro-bind /bin /bin",
            "--ro-bind /lib /lib",
            "--symlink lib /lib64",
            "--ro-bind /usr /usr",
            "--ro-bind /mnt/read-only /mnt/read-only",
            "--bind /mnt/read-write /mnt/read-write",
            "--proc /proc",
            "--dev /dev",
            "--unshare-pid",
            "--new-session",
            "sh"
        ]
        self.assertRunOk(" ".join(cmd))

        # The "--unshare-pid" option creates a new PID namespace.
        # In this new namespace, Bubblewrap act as the PID-1 process.
        # We check the PID-1 executable is bwrap.
        out, ret = self.emulator.run("readlink -f /proc/1/exe")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "/usr/bin/bwrap")

        # Inside the sandbox, we should not see the /root home
        # directory.
        self.assertRunOk("test ! -d /root")

        # Inside the sandbox, we should not be able to remove a file
        # from /bin, even as the root user.
        self.assertRunNotOk("rm -f /bin/ls")

        # We check the hidden file is not visible.
        self.assertRunNotOk("cat /mnt/hidden/file.txt")

        # We check the read-only file is readable.
        out, ret = self.emulator.run("cat /mnt/read-only/file.txt")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "read-only")

        # We also check the read-only file cannot be written.
        cmd = f"echo '{msg}' > /mnt/read-only/file.txt"
        self.assertRunNotOk(cmd)

        # We check the read-write file is readable.
        cmd = "cat /mnt/read-write/file.txt"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "read-write")

        # We check the read-write file is also writable.
        cmd = f"echo '{msg}' > /mnt/read-write/file.txt"
        _, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)

        # We exit from the sandbox.
        self.assertRunOk("exit")

        # Since we exited the sandbox, we check the PID-1
        # is no longer bwrap.
        out, ret = self.emulator.run("readlink -f /proc/1/exe")
        self.assertEqual(ret, 0)
        self.assertNotEqual(out[0], "/usr/bin/bwrap")

        # We should now be able to read the hidden file.
        out, ret = self.emulator.run("cat /mnt/hidden/file.txt")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "hidden")

        # We check the writable file now contains our test message.
        cmd = "cat /mnt/read-write/file.txt"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)

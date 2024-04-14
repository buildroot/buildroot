import os

import infra.basetest


class TestWine(infra.basetest.BRTest):
    # Wine depends on i386 architecture. The pre-build runtime test
    # Kernel (for armv5) cannot be used. The config also uses a ext4
    # rootfs due to the larger Wine footprint. We also enable NLS,
    # which is required for cmd.exe shell to work.
    config = \
        """
        BR2_i386=y
        BR2_x86_pentium4=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.27"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/x86/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF=y
        BR2_PACKAGE_WINE=y
        BR2_SYSTEM_ENABLE_NLS=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="256M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        drive = os.path.join(self.builddir, "images", "rootfs.ext4")
        kern = os.path.join(self.builddir, "images", "bzImage")
        self.emulator.boot(arch="i386",
                           kernel=kern,
                           kernel_cmdline=["root=/dev/vda console=ttyS0"],
                           options=["-M", "pc", "-m", "256M",
                                    "-drive", f"file={drive},if=virtio,format=raw"])
        self.emulator.login()

        # Check the program can run.
        self.assertRunOk("wine --version")

        # Remove the Wine directory to make this test idempotent. This
        # is because we use a persistent storage. This is useful only
        # when the run-tests script is used with the "-k" option.
        self.assertRunOk("rm -rf ~/.wine")

        # Wine usually prints lots of debug messages. We disable all
        # logs for this test. For debugging, this line can be
        # commented, or extra log can also be added. "WINEDEBUG=+all"
        # enable all logs and generates a lot of messages.
        # See: https://wiki.winehq.org/Debug_Channels
        self.assertRunOk("export WINEDEBUG=-all")

        # We force the initialization of the WINEPREFIX
        # directory. This operation can take some time. This will make
        # subsequent wine invocation execution time more stable.
        self.assertRunOk("wineboot --init", timeout=45)

        # We check we can list files in the Windows OS directory.
        cmd = "wine cmd.exe /C 'DIR C:\\WINDOWS\\'"
        self.assertRunOk(cmd, timeout=10)

        # We check we can read a Windows OS specific environment
        # variable. We use "assertIn" rather than "assertEqual"
        # because the cmd.exe shell write extra control characters.
        cmd = "wine cmd.exe /C 'ECHO %OS%'"
        out, ret = self.emulator.run(cmd, timeout=10)
        self.assertEqual(ret, 0)
        self.assertIn("Windows_NT", out[0])

        # We check we can print an arbitrary string with the
        # cmd.exe shell.
        string = "Hello Buildroot !"
        cmd = f"wine cmd.exe /C 'ECHO {string}'"
        out, ret = self.emulator.run(cmd, timeout=10)
        self.assertEqual(ret, 0)
        self.assertIn(string, out[0])

        # We check the VER command reports a Windows OS version.
        cmd = "wine cmd.exe /C 'VER'"
        out, ret = self.emulator.run(cmd, timeout=10)
        self.assertEqual(ret, 0)
        self.assertIn("Microsoft Windows", "\n".join(out))

        # We run the ping.exe command.
        self.assertRunOk("wine ping.exe 127.0.0.1", timeout=10)

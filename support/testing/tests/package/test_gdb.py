import os
import infra.basetest


class BaseGdb(infra.basetest.BRTest):
    def verify_host_gdb(self, prefix="arm-linux"):
        cmd = ["host/bin/%s-gdb" % prefix, "--version"]
        # We don't check the return value, as it automatically raises
        # an exception if the command returns with a non-zero value
        infra.run_cmd_on_host(self.builddir, cmd)

    def boot(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", img,
                                    "-net", "nic",
                                    "-net", "user"])
        self.emulator.login()

    def verify_gdbserver(self):
        cmd = "gdbserver --version"
        self.assertRunOk(cmd)

    def verify_gdb(self):
        cmd = "gdb --version"
        self.assertRunOk(cmd)


class TestGdbHostOnlyDefault(BaseGdb):
    config = \
        infra.basetest.MINIMAL_CONFIG + \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_HOST_GDB=y
        """

    def test_run(self):
        self.verify_host_gdb()


class TestGdbHostOnlyAllFeatures(BaseGdb):
    config = \
        infra.basetest.MINIMAL_CONFIG + \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_HOST_GDB=y
        BR2_PACKAGE_HOST_GDB_TUI=y
        BR2_PACKAGE_HOST_GDB_PYTHON3=y
        BR2_PACKAGE_HOST_GDB_SIM=y
        """

    def test_run(self):
        self.verify_host_gdb()


class TestGdbserverOnly(BaseGdb):
    config = \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_GDB=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        self.boot()
        self.verify_gdbserver()


class TestGdbFullTarget(BaseGdb):
    config = \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_GDB=y
        BR2_PACKAGE_GDB_DEBUGGER=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        self.boot()
        self.verify_gdb()


class TestGdbHostOnly9x(BaseGdb):
    config = \
        infra.basetest.MINIMAL_CONFIG + \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_HOST_GDB=y
        BR2_GDB_VERSION_9_2=y
        """

    def test_run(self):
        self.verify_host_gdb()


class TestGdbHostGdbserver9x(BaseGdb):
    config = \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_HOST_GDB=y
        BR2_GDB_VERSION_9_2=y
        BR2_PACKAGE_GDB=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        self.verify_host_gdb()
        self.boot()
        self.verify_gdbserver()


class TestGdbHostGdbTarget9x(BaseGdb):
    config = \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_HOST_GDB=y
        BR2_GDB_VERSION_9_2=y
        BR2_PACKAGE_GDB=y
        BR2_PACKAGE_GDB_DEBUGGER=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        self.verify_host_gdb()
        self.boot()
        self.verify_gdb()


class TestGdbHostOnly11x(BaseGdb):
    config = \
        infra.basetest.MINIMAL_CONFIG + \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_HOST_GDB=y
        BR2_GDB_VERSION_11=y
        """

    def test_run(self):
        self.verify_host_gdb()


class TestGdbHostGdbserver11x(BaseGdb):
    config = \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_HOST_GDB=y
        BR2_GDB_VERSION_11=y
        BR2_PACKAGE_GDB=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        self.verify_host_gdb()
        self.boot()
        self.verify_gdbserver()


class TestGdbHostGdbTarget11x(BaseGdb):
    config = \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_HOST_GDB=y
        BR2_GDB_VERSION_11=y
        BR2_PACKAGE_GDB=y
        BR2_PACKAGE_GDB_DEBUGGER=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        self.verify_host_gdb()
        self.boot()
        self.verify_gdb()


class TestGdbArc(BaseGdb):
    config = \
        """
        BR2_arcle=y
        BR2_archs4x_rel31=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_PACKAGE_HOST_GDB=y
        BR2_PACKAGE_GDB=y
        BR2_PACKAGE_GDB_SERVER=y
        BR2_PACKAGE_GDB_DEBUGGER=y
        """

    def test_run(self):
        self.verify_host_gdb("arc-linux")

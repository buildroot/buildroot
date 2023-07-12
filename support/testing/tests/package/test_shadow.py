import os

from infra.basetest import BRTest


class TestShadow(BRTest):
    username = 'user_test'
    # Need to use a different toolchain than the default due to
    # shadow package requiring a toolchain w/ headers >= 4.14
    config = \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_ARMV5_EABI_GLIBC_BLEEDING_EDGE=y
        BR2_PACKAGE_SHADOW=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="65536"
        """
    timeout = 60

    def login(self):
        img = os.path.join(self.builddir, "images", "rootfs.ext4")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           kernel_cmdline=["root=/dev/mmcblk0",
                                           "rootfstype=ext4"],
                           options=["-drive", f"file={img},if=sd,format=raw"])
        self.emulator.login()

    def test_nologin(self):
        self.login()

        self.assertRunOk("! nologin")
        cmd = 'test "$(nologin)" = "This account is currently not available."'
        self.assertRunOk(cmd)

    def test_useradd_del(self):
        username = self.username
        self.login()

        self.assertRunOk(f'userdel {username} || true')
        self.assertRunOk(f'groupdel {username} || true')
        self.assertRunOk(f'useradd -s /bin/sh {username}')
        self.assertRunOk(f'test $(su {username} -c "whoami") = {username}')
        self.assertRunOk(f'userdel {username}')

    def test_usermod(self):
        username = self.username
        new_home = '/tmp'
        self.login()

        self.assertRunOk(f'userdel {username} || true')
        self.assertRunOk(f'groupdel {username} || true')
        self.assertRunOk(f'useradd -s /bin/sh {username}')
        self.assertRunOk(f'usermod {username} --home {new_home}')
        self.assertRunOk(f'test $(su {username} -c \'echo $HOME\') = {new_home}')
        self.assertRunOk(f'userdel {username}')

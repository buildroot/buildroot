import os

import infra.basetest


class TestAudit(infra.basetest.BRTest):
    # This test needs a Kernel with the audit support (the builtin
    # test Kernel does not have this support). Since the audit support
    # enabled by default, a kernel fragment is not required.
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.58"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_AUDIT=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt",
                                    "-cpu", "cortex-a57",
                                    "-m", "256M",
                                    "-initrd", img])
        self.emulator.login()

        # We check the program can run by showing its version. This
        # invocation also checks the Kernel has the audit support
        # enabled.
        self.assertRunOk("auditctl -v")

        # We define a normal user name for this test.
        user = "audit-test"

        # Audit rule inspired from auditctl manual page examples.

        # We add an audit rule logging write access on the
        # system password file.
        cmd = "auditctl -a always,exit -F path=/etc/shadow -F perm=wa"
        self.assertRunOk(cmd)

        # We do a read-only access on this file, as the root user.
        self.assertRunOk("cat /etc/shadow")

        # We check our previous read-only access did NOT generated an
        # event record.
        ausearch_cmd = "ausearch --format text"
        out, ret = self.emulator.run(ausearch_cmd)
        self.assertEqual(ret, 0)
        open_shadow_str = "acting as root, successfully opened-file /etc/shadow"
        self.assertNotIn(open_shadow_str, "\n".join(out))

        # We create a normal user. This will modify the shadow password file.
        cmd = f"adduser -D -h /tmp -H -s /bin/sh {user}"
        self.assertRunOk(cmd)

        # We are now expecting an event record of this modification.
        out, ret = self.emulator.run(ausearch_cmd)
        self.assertEqual(ret, 0)
        self.assertIn(open_shadow_str, "\n".join(out))

        # We add a new audit rule, recording failed open of the system
        # password file.
        cmd = "auditctl -a always,exit -S openat -F success=0 -F path=/etc/shadow"
        self.assertRunOk(cmd)

        # We attempt to read the system password file as our new
        # normal user. This command is expected to fail (as only root
        # can root is supposed to read this file).
        cmd = f"su - {user} -c 'cat /etc/shadow'"
        _, ret = self.emulator.run(cmd)
        self.assertNotEqual(ret, 0)

        # Our last failed read attempt is supposed to have generated
        # an event. We check we can see it in the log.
        out, ret = self.emulator.run(ausearch_cmd)
        self.assertEqual(ret, 0)
        evt_str = f"acting as {user}, unsuccessfully opened-file /etc/shadow"
        self.assertIn(evt_str, "\n".join(out))

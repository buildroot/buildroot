import os

import infra.basetest


class TestRtTests(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_RT_TESTS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We cannot easily test realtime properties in a CI/emulator
        # environment. Instead, this test runs few rt-tests programs
        # in small scenario configurations (to make sure the execution
        # will remain short). It just makes sure the execution returns
        # a success code. Also, to avoid making the logs too big, we
        # generally pass the "--quiet" option to have a summary at the
        # end of the execution.
        test_cmds = [
            "cyclictest --quiet --loops=200",
            "hackbench --fds=2 --groups=3 --loops=5",
            "pi_stress --inversions=100",
            "ptsematest --quiet --loops=100",
            "rt-migrate-test --quiet --loops=5",
            "signaltest --quiet --loops=200",
            "sigwaittest --quiet --loops=100"
        ]

        for cmd in test_cmds:
            self.assertRunOk(cmd)

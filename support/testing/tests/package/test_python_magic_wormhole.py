import os
import time

from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3MagicWormhole(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_MAGIC_WORMHOLE=y
        BR2_PACKAGE_PYTHON_MAGIC_WORMHOLE_MAILBOX_SERVER=y
        BR2_PACKAGE_PYTHON_MAGIC_WORMHOLE_TRANSIT_RELAY=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    timeout = 60

    def twistd_cmd(self, command):
        s = "twistd"
        s += " --pidfile=/tmp/{}.pid".format(command)
        s += " --logfile=/tmp/{}.log".format(command)
        s += " {}".format(command)

        return s

    def test_run(self):
        code = "123-hello-buildroot"
        text = "Hello Buildroot!"

        relay_url = "ws://localhost:4000/v1"
        transit_helper = "tcp:localhost:4001"

        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5", kernel="builtin",
                           options=["-initrd", img])

        self.emulator.login()

        cmd = self.twistd_cmd("wormhole-mailbox")
        self.assertRunOk(cmd, timeout=30)

        cmd = self.twistd_cmd("transitrelay")
        self.assertRunOk(cmd, timeout=30)

        wormhole_cmd = "wormhole --relay-url={} --transit-helper={}".format(
            relay_url, transit_helper)

        cmd = wormhole_cmd
        cmd += f" send --code={code} --text=\"{text}\""
        cmd += " &> /dev/null &"
        self.assertRunOk(cmd)

        time.sleep(30 * self.timeout_multiplier)

        wormhole_env = "_MAGIC_WORMHOLE_TEST_KEY_TIMER=100 "
        wormhole_env += "_MAGIC_WORMHOLE_TEST_VERIFY_TIMER=100 "
        cmd = wormhole_env + wormhole_cmd + " receive {}".format(code)
        output, exit_code = self.emulator.run(cmd, timeout=35)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], text)

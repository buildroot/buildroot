import os
import time

import infra.basetest


class TestMosquitto(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_MOSQUITTO=y
        BR2_PACKAGE_MOSQUITTO_BROKER=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        topic = "br-test-topic"
        log = "mqtt.log"
        msg = "Hello Buildroot!"

        # We subscribe to a topic and write one message to a log file.
        cmd = f"( mosquitto_sub -t {topic} -C 1 > {log} 2> /dev/null & )"
        self.assertRunOk(cmd)

        # We give some time to the subscriber process to settle.
        time.sleep(5)

        # We publish a message.
        self.assertRunOk(f"mosquitto_pub -t {topic} -m '{msg}'")

        # We give some more time to the subscriber process to write
        # the log and quit.
        time.sleep(5)

        # We check the log file contains our message.
        out, ret = self.emulator.run(f"cat {log}")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)

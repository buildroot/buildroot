import os
import json
import time

import infra.basetest


class TestFluentBit(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_FLUENT_BIT=y
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Enable the http server
        cmd = ("sed -i 's/http_server  Off/http_server  On/g' "
               "/etc/fluent-bit/fluent-bit.conf && "
               "/etc/init.d/S99fluent-bit restart")
        _, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)

        # Give some runtime
        time.sleep(5)

        # Check the uptime
        cmd = "wget -qO- http://127.0.0.1:2020/api/v1/uptime"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        uptime = json.loads(output[0])
        self.assertGreater(uptime["uptime_sec"], 3)

        # Check the metrics
        cmd = "wget -qO- http://127.0.0.1:2020/api/v1/metrics"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        metrics = json.loads(output[0])
        self.assertGreater(metrics["input"]["cpu.0"]["records"], 0)
        self.assertGreater(metrics["output"]["stdout.0"]["proc_records"], 0)

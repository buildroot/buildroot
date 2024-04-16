import json
import os

import infra.basetest


class TestJq(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_jq/rootfs-overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_JQ=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute.
        self.assertRunOk("jq --version")

        # Run jq on examples extracted from JSON RFC:
        # https://www.rfc-editor.org/rfc/rfc8259.txt
        for i in range(1, 6):
            fname = f"ex13-{i}.json"
            cmd = f"jq -M '.' {fname}"
            self.assertRunOk(cmd)

        # Check the execution fails on a non JSON file.
        cmd = "jq -M '.' broken.json"
        _, ret = self.emulator.run(cmd)
        self.assertNotEqual(ret, 0)

        # Check an execution of a simple query. Note that output is a
        # JSON (quoted) string.
        cmd = "jq -M '.[1].City' ex13-2.json"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], '"SUNNYVALE"')

        # Run the same query with the -r option, to output raw text
        # (i.e. strings without quotes).
        cmd = "jq -r -M '.[1].City' ex13-2.json"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "SUNNYVALE")

        # Print the ex13-2.json file as compact JSON (with option -c).
        cmd = "jq -c -M '.' ex13-2.json"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        # We reload this compact string using the Python json parser,
        # to test interoperability. We check the same element as in
        # previous queries in the Python object.
        json_data = json.loads(out[0])
        self.assertEqual(json_data[1]["City"], "SUNNYVALE")

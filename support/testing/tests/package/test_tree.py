import json
import os
import xml.etree.ElementTree as ET

import infra.basetest


class TestTree(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_TREE=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.assertRunOk("tree --version")

        # Simple invocations on a path.
        self.assertRunOk("tree /usr")
        self.assertRunOk("tree -d /usr")
        self.assertRunOk("tree -dx /")

        # Check we see the /usr/bin/tree file in the output.
        out, ret = self.emulator.run("tree -f /usr")
        self.assertEqual(ret, 0)
        self.assertIn("/usr/bin/tree", "\n".join(out))

        # Check we can parse the JSON output and the summary report.
        out, ret = self.emulator.run("tree -J /usr")
        self.assertEqual(ret, 0)
        json_str = "\n".join(out)
        json_data = json.loads(json_str)
        # Report is the last element.
        json_report = json_data[-1]
        self.assertEqual(json_report["type"], "report")
        self.assertGreater(json_report["directories"], 0)
        self.assertGreater(json_report["files"], 0)

        # Check we can parse the XML output and the summary report.
        out, ret = self.emulator.run("tree -X /usr")
        self.assertEqual(ret, 0)
        xml_str = "\n".join(out)
        xml_root = ET.fromstring(xml_str)
        self.assertEqual(xml_root.tag, "tree")
        xml_report = xml_root.find("report")
        self.assertGreater(int(xml_report.find("directories").text), 0)
        self.assertGreater(int(xml_report.find("files").text), 0)

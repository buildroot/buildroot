import hashlib
import re
import zlib
from pathlib import Path

import infra.basetest

EXAMPLE_ITS = Path(__file__).parent / "test_uboot_tools/example.its"


def get_hashes(output: str) -> dict[str, str]:
    """Get hashes from dumpimage output (assumes exactly one image in FIT)"""
    pat = re.compile(
        r"Hash algo:\s+(\S+)$\s+Hash value:\s+(\w+)$", flags=re.MULTILINE)
    return dict(pat.findall(output))


def calc_hashes(data: bytes) -> dict[str, str]:
    """Calculate the hashes dumpimage should report for a given blob"""
    return {
        "crc32": f"{zlib.crc32(data):08x}",
        "md5": hashlib.md5(data).hexdigest(),
        "sha1": hashlib.sha1(data).hexdigest(),
        "sha256": hashlib.sha256(data).hexdigest(),
        "sha384": hashlib.sha384(data).hexdigest(),
        "sha512": hashlib.sha512(data).hexdigest(),
    }


class TestUbootTools(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_uboot_tools")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_UBOOT_TOOLS=y
        BR2_PACKAGE_UBOOT_TOOLS_DUMPIMAGE=y
        BR2_PACKAGE_UBOOT_TOOLS_FIT_SUPPORT=y
        BR2_PACKAGE_UBOOT_TOOLS_MKIMAGE=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        ramdisk = Path(self.builddir) / "images/rootfs.cpio"
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", str(ramdisk)])
        self.emulator.login()

        self.assertRunOk(f"mkimage -f /{EXAMPLE_ITS.name} /tmp/test.fit")

        cmd = "dumpimage -l /tmp/test.fit"
        out, exit_code = self.emulator.run(cmd, -1)
        self.assertEqual(
            exit_code,
            0,
            "\nFailed to run: {}\noutput was:\n{}".format(cmd, '  '+'\n  '.join(out))
        )
        reported = get_hashes("\n".join(out))
        expected = calc_hashes(EXAMPLE_ITS.read_bytes())
        for h in expected:
            with self.subTest(hash=h):
                self.assertEqual(expected[h], reported[h])
        # Python does not have built-in CRC16 support, just check it is present
        self.assertIn("crc16-ccitt", reported)


class TestHostUbootTools(infra.basetest.BRHostPkgTest):
    hostpkgs = ["host-uboot-tools"]
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_HOST_UBOOT_TOOLS=y
        BR2_PACKAGE_HOST_UBOOT_TOOLS_FIT_SUPPORT=y
        """

    def test_run(self):
        cmd = ["host/bin/mkimage", "-f", str(EXAMPLE_ITS), "test.fit"]
        infra.run_cmd_on_host(self.builddir, cmd)

        cmd = ["host/bin/dumpimage", "-l", "test.fit"]
        reported = get_hashes(infra.run_cmd_on_host(self.builddir, cmd))
        expected = calc_hashes(EXAMPLE_ITS.read_bytes())
        for h in expected:
            with self.subTest(hash=h):
                self.assertEqual(expected[h], reported[h])
        # Python does not have built-in CRC16 support, just check it is present
        self.assertIn("crc16-ccitt", reported)

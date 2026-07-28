import hashlib
import re
import subprocess
import zlib
from pathlib import Path

import infra.basetest

EXAMPLE_ITS = Path(__file__).parent / "test_uboot_tools/example.its"
KEY_DTS = Path(__file__).parent / "test_uboot_tools/key.dts"
SIGNED_ITS = Path(__file__).parent / "test_uboot_tools/signed.its"


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
        BR2_PACKAGE_HOST_UBOOT_TOOLS_FIT_SIGNATURE_SUPPORT=y
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

        # See U-Boot FIT Signature Verification documentation:
        # https://source.denx.de/u-boot/u-boot/-/blob/v2026.07/doc/usage/fit/signature.rst
        keydir = Path(self.builddir) / "keys"
        keydir.mkdir(exist_ok=True)

        # We generate a prublic/private key pair to sign the image.
        cmd = [
            "host/bin/openssl", "req", "-batch", "-new", "-x509", "-nodes",
            "-newkey", "rsa:2048", "-keyout", str(keydir / "dev.key"),
            "-out", str(keydir / "dev.crt"), "-subj", "/CN=Buildroot FIT test",
        ]
        infra.run_cmd_on_host(self.builddir, cmd)

        # We compile the empty dtb that will be used to store the
        # public key.
        cmd = [
            "host/bin/dtc", "-I", "dts", "-O", "dtb", "-p", "0x1000",
            "-o", "test-key.dtb", str(KEY_DTS),
        ]
        infra.run_cmd_on_host(self.builddir, cmd)

        # We sign the image and write the public key in our key
        # storage dtb.
        cmd = [
            "host/bin/mkimage", "-f", str(SIGNED_ITS), "-k", str(keydir),
            "-K", "test-key.dtb", "-r", "signed.fit",
        ]
        infra.run_cmd_on_host(self.builddir, cmd)

        # We check there is a signature present in the FIT image.
        cmd = [
            "host/bin/fdtget", "-t", "bx", "signed.fit",
            "/configurations/config-1/signature-1", "value",
        ]
        signature = infra.run_cmd_on_host(self.builddir, cmd).split()
        self.assertEqual(len(signature), 256)

        # We check the key is marked as required for the configuration.
        cmd = [
            "host/bin/fdtget", "-t", "s", "test-key.dtb",
            "/signature/key-dev", "required",
        ]
        required = infra.run_cmd_on_host(self.builddir, cmd).strip()
        self.assertEqual(required, "conf")

        # We actually check the signature is valid.
        cmd = [
            "host/bin/fit_check_sign", "-f", "signed.fit",
            "-k", "test-key.dtb",
        ]
        infra.run_cmd_on_host(self.builddir, cmd)

        # We "corrupt" the signature, by setting it to zero.
        cmd = [
            "host/bin/fdtput", "-t", "bx", "signed.fit",
            "/configurations/config-1/signature-1", "value", "00",
        ]
        infra.run_cmd_on_host(self.builddir, cmd)

        # We check again the siganute, and expect a failure.
        cmd = [
            "host/bin/fit_check_sign", "-f", "signed.fit",
            "-k", "test-key.dtb",
        ]
        with self.assertRaises(subprocess.CalledProcessError):
            infra.run_cmd_on_host(self.builddir, cmd)

import os

import infra.basetest


class TestLibCamera(infra.basetest.BRTest):
    # A specific configuration is needed for testing libcamera:
    # a kernel config fragment enables v4l2 vimc driver.
    # The libevent package is also enabled to have the libcamera "cam"
    # test application.
    kernel_fragment = \
        infra.filepath("tests/package/test_libcamera/linux-vimc.fragment")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.76"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kernel_fragment}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_LIBCAMERA=y
        BR2_PACKAGE_LIBCAMERA_PIPELINE_VIMC=y
        BR2_PACKAGE_LIBEVENT=y
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
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "256M",
                                    "-initrd", img])
        self.emulator.login()

        # The Kernel config of this test has only one v4l2 vimc
        # driver. The camera index is expected to be #1.
        cam_idx = 1

        # We test libcamera with its simple "cam" application, by
        # requesting a list of available cameras.
        cmd = "cam --list"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        # libcamera generates info messages. We filter only the
        # line(s) starting with our camera index.
        cam_line = [ln for ln in out if ln.startswith(f"{cam_idx}:")]
        # We should have the vimc camera in this line.
        self.assertIn("platform/vimc.0", cam_line[0])

        # List the camera information.
        cmd = f"cam --camera {cam_idx} --info"
        self.assertRunOk(cmd)

        # List the camera controls and check we have a brightness
        # control.
        cmd = f"cam --camera {cam_idx} --list-controls"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertIn("Control: Brightness:", "\n".join(out))

        # List the camera properties and check we have a camera
        # "Model" property.
        cmd = f"cam --camera {cam_idx} --list-properties"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertIn("Property: Model = ", "\n".join(out))

        # Capture few frames.
        cmd = f"cam --camera {cam_idx} --capture=5"
        cmd += " --stream width=160,height=120,role=video,pixelformat=RGB888"
        self.assertRunOk(cmd)

import os
import time

import infra.basetest
from ..graphics_base import GraphicsBase


class TestWeston(infra.basetest.BRTest, GraphicsBase):
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_EUDEV=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_ROOTFS_OVERLAY="{}"
        BR2_PER_PACKAGE_DIRECTORIES=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.44"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{}"
        BR2_PACKAGE_LIBDRM=y
        BR2_PACKAGE_MESA3D=y
        BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_SWRAST=y
        BR2_PACKAGE_MESA3D_LLVM=y
        BR2_PACKAGE_MESA3D_OPENGL_EGL=y
        BR2_PACKAGE_MESA3D_OPENGL_ES=y
        BR2_PACKAGE_WAYLAND_UTILS=y
        BR2_PACKAGE_WESTON=y
        BR2_PACKAGE_WESTON_SIMPLE_CLIENTS=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
                infra.filepath("tests/package/test_weston/overlay"),
                infra.filepath("tests/package/test_weston/linux-vkms.fragment")
             )

    def start_weston(self):
        self.assertRunOk("export XDG_RUNTIME_DIR=/tmp")

        cmd = "( weston"
        cmd += " --config=/etc/weston.ini"
        cmd += " --continue-without-input"
        cmd += " --log=/tmp/weston.log"
        cmd += " &> /dev/null & )"
        self.assertRunOk(cmd)

        self.assertRunOk("export WAYLAND_DISPLAY=wayland-1")

    def wait_for_weston(self):
        # We wait for the wayland socket to appear...
        wayland_socket = "${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}"
        cmd = f"while [ ! -e \"{wayland_socket}\" ] ; do sleep 1 ; done"
        self.assertRunOk(cmd, timeout=10)
        time.sleep(4)

    def stop_weston(self):
        cmd = "killall weston"
        self.assertRunOk(cmd)
        time.sleep(3)

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0", "vt.global_cursor_default=0"],
                           options=["-M", "virt",
                                    "-cpu", "cortex-a57",
                                    "-smp", "4",
                                    "-m", "512M",
                                    "-initrd", img])
        self.emulator.login()

        # This test uses the vkms DRM Kernel driver. This driver can
        # generate kernel warning messages in some cases (e.g. "vblank
        # timer overrun"). Those messages can happen on slow test
        # runners. This warning is not an issue in this test: it is
        # not checking performance here; it just checks the rendering
        # pipeline is functional. For that reason, this test adds the
        # file "/etc/default/klogd" to only show emergency messages
        # (level value 0) on the console.

        # Check the weston binary can execute
        self.assertRunOk("weston --version")

        self.start_weston()
        self.wait_for_weston()

        # Check a simple info client can communicate with the compositor
        self.assertRunOk("wayland-info", timeout=10)

        # We get 10 consecutive DRM frame CRCs and count how many
        # unique CRCs we have. Since weston is supposed to run idle,
        # we should have 10 times the same display CRC.
        self.assertTrue(len(self.get_n_fb_crc(uniq=True)) == 1)

        # We save the CRC value of an empty weston desktop for
        # later...
        weston_desktop_crc = self.get_n_fb_crc(count=1)[0]

        # We start the weston-simple-egl in background...  Every
        # rendered frame is supposed to be different (as the triangle
        # animation is derived from the system time). Since all the
        # rendering (client application and compositor) is in
        # software, we sleep a bit to let those program to settle.
        self.assertRunOk("( weston-simple-egl >/dev/null 2>&1 & )")

        # Since the weston-simple-egl client is supposed to run and
        # display something, we are now supposed to measure a
        # different display CRC than the one we measured when the
        # desktop was empty.
        for i in range(600):
            crc = self.get_n_fb_crc(count=1)[0]
            if crc != weston_desktop_crc:
                break
            time.sleep(1)
        self.assertNotEqual(crc, weston_desktop_crc)

        # While weston-simple-egl is running, we check the VKMS DRM
        # CRCs are now changing. We get many CRCs, one per display
        # driver refresh (at ~60Hz). Since all the rendering is in
        # software, we can expect a slow frame rate. In 300 captured
        # CRCs (5s), we expect at least 5 different values (i.e. 1 fps).
        # This guarantees the rendering pipeline is working, while we
        # remain very permissive to slow emulation situations.
        # Increase timeout, as the command is expected to run about 5s,
        # which is the default timeout.
        crcs = self.get_n_fb_crc(count=300, timeout=10)
        self.assertGreaterEqual(len(crcs), 5)

        # We stop weston-simple-egl, and sleep a bit to let Weston do
        # its cleanup and desktop repaint refresh...
        self.assertRunOk("killall weston-simple-egl")

        # After we stopped the application, we should have the initial
        # weston desktop background. The CRC we measure now should be
        # the same as the one we saved earlier.
        for i in range(600):
            crc = self.get_n_fb_crc(count=1)[0]
            if crc == weston_desktop_crc:
                break
            time.sleep(1)
        self.assertEqual(crc, weston_desktop_crc)

        self.stop_weston()

        # Now weston is supposed to be stopped,
        # a simple client is expected to fail.
        _, exit_code = self.emulator.run("wayland-info")
        self.assertNotEqual(exit_code, 0)

import os
import time

import infra.basetest


class TestWeston(infra.basetest.BRTest):
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

    def gen_read_disp_crcs_cmd(self, count=1):
        # DRM CRCs are exposed through a sysfs pseudo file, one measure
        # per line. The first column is the frame number, the second
        # column is the CRC measure. We use "head" to get the needed
        # CRC count.
        disp_crc_path = "/sys/kernel/debug/dri/0/crtc-0/crc/data"
        cmd = f"head -{count} {disp_crc_path}"

        # The DRM CRC sysfs pseudo file lines are terminated by '\n'
        # and '\0'. We remove the '\0' to have a text-only output.
        cmd += " | tr -d '\\000'"

        # Finally, we drop the frame counter, and keep only the second
        # column (CRC values)
        cmd += " | cut -f 2 -d ' '"

        return cmd

    def gen_count_unique_disp_crcs_cmd(self, count=10):
        # We get the command generating one CRC per line...
        cmd = self.gen_read_disp_crcs_cmd(count)
        # ...then count the number of unique values
        cmd += " | uniq | wc -l"
        return cmd

    def start_weston(self):
        self.assertRunOk("export XDG_RUNTIME_DIR=/tmp")

        cmd = "weston"
        cmd += " --config=/etc/weston.ini"
        cmd += " --continue-without-input"
        cmd += " --log=/tmp/weston.log"
        cmd += " &> /dev/null &"
        self.assertRunOk(cmd)

        self.assertRunOk("export WAYLAND_DISPLAY=wayland-1")

    def wait_for_weston(self):
        # We wait for the wayland socket to appear...
        wayland_socket = "${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY}"
        cmd = f"while [ ! -e \"{wayland_socket}\" ] ; do sleep 1 ; done"
        self.assertRunOk(cmd, timeout=10)
        time.sleep(4)

    def stop_weston(self):
        cmd = "killall weston && sleep 3"
        self.assertRunOk(cmd)

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt",
                                    "-cpu", "cortex-a57",
                                    "-smp", "4",
                                    "-m", "256M",
                                    "-initrd", img])
        self.emulator.login()

        # Check the weston binary can execute
        self.assertRunOk("weston --version")

        self.start_weston()
        self.wait_for_weston()

        # Check a simple info client can communicate with the compositor
        self.assertRunOk("wayland-info", timeout=10)

        # This test will use the Kernel VKMS DRM Display CRC support,
        # which is exposed in debugfs. See:
        # https://docs.kernel.org/gpu/drm-uapi.html#display-crc-support
        self.assertRunOk("mount -t debugfs none /sys/kernel/debug/")

        # We get 10 consecutive DRM frame CRCs and count how many
        # unique CRCs we have. Since weston is supposed to run idle,
        # we should have 10 times the same display CRC.
        cmd = self.gen_count_unique_disp_crcs_cmd()
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(int(output[0]), 1)

        # We save the CRC value of an empty weston desktop for
        # later...
        cmd = self.gen_read_disp_crcs_cmd()
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        weston_desktop_crc = int(output[0], 16)

        # We start the weston-simple-egl in background...  Every
        # rendered frame is supposed to be different (as the triangle
        # animation is derived from the system time). Since all the
        # rendering (client application and compositor) is in
        # software, we sleep a bit to let those program to settle.
        self.assertRunOk("weston-simple-egl >/dev/null 2>&1 &")
        time.sleep(8)

        # Since the weston-simple-egl client is supposed to run and
        # display something, we are now supposed to measure a
        # different display CRC than the one we measured when the
        # desktop was empty.
        cmd = self.gen_read_disp_crcs_cmd()
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertNotEqual(int(output[0], 16), weston_desktop_crc)

        # While weston-simple-egl is running, we check the VKMS DRM
        # CRCs are now changing. We get many CRCs, one per display
        # driver refresh (at ~60Hz). Since all the rendering is in
        # software, we can expect a slow frame rate. In 300 captured
        # CRCs (5s), we expect at least 5 different values (i.e. 1 fps).
        # This guarantees the rendering pipeline is working, while we
        # remain very permissive to slow emulation situations.
        # Increase timeout, as the command is expected to run about 5s,
        # which is the default timeout.
        cmd = self.gen_count_unique_disp_crcs_cmd(300)
        output, exit_code = self.emulator.run(cmd, timeout=10)
        self.assertEqual(exit_code, 0)
        self.assertGreaterEqual(int(output[0]), 5)

        # We stop weston-simple-egl, and sleep a bit to let Weston do
        # its cleanup and desktop repaint refresh...
        self.assertRunOk("killall weston-simple-egl")
        time.sleep(4)

        # After we stopped the application, we should have the initial
        # weston desktop background. The CRC we measure now should be
        # the same as the one we saved earlier.
        cmd = self.gen_read_disp_crcs_cmd()
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(int(output[0], 16), weston_desktop_crc)

        self.stop_weston()

        # Now weston is supposed to be stopped,
        # a simple client is expected to fail.
        _, exit_code = self.emulator.run("wayland-info")
        self.assertNotEqual(exit_code, 0)

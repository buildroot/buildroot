import os

import infra
import infra.basetest
from infra.builder import Builder


# gitlab-runner: 2xlarge
class TestVirglrendererNestedQemu(infra.basetest.BRTest):
    outer_kern_frag = \
        infra.filepath("tests/package/test_virglrenderer/linux-outer.fragment")
    inner_kern_frag = \
        infra.filepath("tests/package/test_virglrenderer/linux-inner.fragment")
    rootfs_overlay = \
        infra.filepath("tests/package/test_virglrenderer/rootfs-overlay")

    # Softpipe has no hardware dependencies and does not pull LLVM into the
    # outer build, unlike llvmpipe/lavapipe.
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.21"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{outer_kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF=y
        BR2_PACKAGE_LIBGLVND=y
        BR2_PACKAGE_MESA3D=y
        BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_SOFTPIPE=y
        BR2_PACKAGE_MESA3D_OPENGL_EGL=y
        BR2_PACKAGE_QEMU=y
        BR2_PACKAGE_QEMU_SYSTEM=y
        # BR2_PACKAGE_QEMU_SYSTEM_KVM is not set
        BR2_PACKAGE_QEMU_SYSTEM_TCG=y
        # BR2_PACKAGE_QEMU_BLOBS is not set
        BR2_PACKAGE_QEMU_CHOOSE_TARGETS=y
        BR2_PACKAGE_QEMU_TARGET_AARCH64=y
        BR2_PACKAGE_QEMU_VIRGLRENDERER=y
        BR2_TARGET_ROOTFS_INITRAMFS=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    inner_config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.21"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{inner_kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF=y
        BR2_PACKAGE_KMSCUBE=y
        BR2_PACKAGE_LIBDRM=y
        BR2_PACKAGE_LIBGLVND=y
        BR2_PACKAGE_MESA3D=y
        BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_VIRGL=y
        BR2_PACKAGE_MESA3D_OPENGL_EGL=y
        BR2_PACKAGE_MESA3D_OPENGL_ES=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def setUp(self):
        self.inner_builder = None
        super().setUp()

        self.inner_builddir = os.path.join(self.outputdir,
                                           f"{self.testname}-inner")
        config = self.inner_config
        config += f'\nBR2_DL_DIR="{self.downloaddir}"\n'
        config += f"\nBR2_JLEVEL={self.jlevel}\n"
        self.inner_builder = Builder(config, self.inner_builddir,
                                     self.logtofile, self.jlevel)

        if not self.keepbuilds:
            self.inner_builder.delete()

        if not self.inner_builder.is_finished():
            self.show_msg("Building inner")
            self.inner_builder.configure(
                make_extra_opts=[f"BR2_EXTERNAL={':'.join(self.br2_external)}"])
            self.inner_builder.build()
            self.show_msg("Building inner done")

    def tearDown(self):
        try:
            super().tearDown()
        finally:
            if self.inner_builder and not self.keepbuilds:
                self.inner_builder.delete()

    def boot_outer(self):
        kern = os.path.join(self.builddir, "images", "Image")
        inner_img_dir = os.path.join(self.inner_builddir, "images")
        virtfs_tag = "br-inner"
        virtfs_opts = [
            f"local,path={inner_img_dir}",
            f"mount_tag={virtfs_tag}",
            "security_model=mapped-xattr",
            "readonly=on"
        ]
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt",
                                    "-cpu", "cortex-a57",
                                    "-m", "1536M",
                                    "-smp", "4",
                                    "-vga", "none",
                                    "-virtfs", ",".join(virtfs_opts)])
        self.emulator.login()
        self.assertRunOk(f"mount -t 9p {virtfs_tag} /mnt/")

    def boot_inner(self):
        qemu_cmd = "env LIBGL_ALWAYS_SOFTWARE=1 GALLIUM_DRIVER=softpipe"
        qemu_cmd += " qemu-system-aarch64"
        qemu_cmd += " -M virt,accel=tcg"
        qemu_cmd += " -cpu cortex-a57"
        qemu_cmd += " -m 512M"
        qemu_cmd += " -nodefaults"
        qemu_cmd += " -display egl-headless,gl=on"
        qemu_cmd += " -device virtio-gpu-gl-pci"
        qemu_cmd += " -serial stdio"
        qemu_cmd += " -kernel /mnt/Image"
        qemu_cmd += " -initrd /mnt/rootfs.cpio"
        qemu_cmd += " -append 'console=ttyAMA0 br-inner-virgl'"

        # qemu runs in the foreground on the current serial console. Once it
        # starts, the next login prompt belongs to the inner guest.
        self.emulator.qemu.sendline(qemu_cmd)
        self.emulator.login(timeout=180)

    def test_run(self):
        self.boot_outer()
        self.assertRunOk("while [ ! -e /dev/dri/renderD128 ]; do sleep 1; done",
                         timeout=30)

        self.boot_inner()

        out, ret = self.emulator.run("cat /proc/cmdline")
        self.assertEqual(ret, 0)
        self.assertIn("br-inner-virgl", out[0])

        cmd = "env MESA_LOADER_DRIVER_OVERRIDE=virtio_gpu"
        cmd += " kmscube --vmode=640x480 --count=10"
        out, ret = self.emulator.run(cmd, timeout=60)
        self.assertEqual(ret, 0)

        renderer = "\n".join([line for line in out
                              if line.strip().startswith("renderer:")])
        self.assertRegex(renderer, r'(?i)renderer:\s*"virgl \(softpipe\)"')

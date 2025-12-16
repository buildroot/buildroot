import os

import infra.basetest


class TestKvmTool(infra.basetest.BRTest):
    # This test passes the Buildroot image directory to the emulated
    # guest using the 9p virtiofs. This guest enables the
    # virtualization support. It will start a nested KVM virtual
    # machine, using the same Kernel/initramfs images. For these
    # reasons, we need a specific kernel configuration that enables
    # KVM and 9P.
    kern_frag = \
        infra.filepath("tests/package/test_kvmtool/linux-kvm.fragment")
    rootfs_overlay = \
        infra.filepath("tests/package/test_kvmtool/rootfs-overlay")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.1"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_KVMTOOL=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        kern = os.path.join(self.builddir, "images", "Image")
        img_dir = os.path.join(self.builddir, "images")
        virtfs_tag = "br-imgs"
        virtfs_opts = [
            f"local,path={img_dir}",
            f"mount_tag={virtfs_tag}",
            "security_model=mapped-xattr",
            "readonly"
        ]
        qemu_opts = ["-M", "virt,gic-version=3,virtualization=on",
                     "-cpu", "cortex-a57",
                     "-smp", "4",
                     "-m", "1G",
                     "-virtfs", ','.join(virtfs_opts),
                     "-initrd", img]
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           options=qemu_opts)
        self.emulator.login()

        # Test the program can execute.
        self.assertRunOk("lkvm --version")

        # We mount the virtfs to get the Kernel and initramfs from the
        # test host.
        self.assertRunOk(f"mount -t 9p {virtfs_tag} /mnt/")

        # We define an arbitrary kernel command line argument that we
        # will use to detect we are in our virtual machine.
        kvm_karg = "br-kvm"

        # The number of CPU of our virtual machine
        kvm_nproc = 2

        # We run the KVM virtual machine
        cmd = "lkvm run"
        cmd += " --kernel /mnt/Image"
        cmd += " --initrd /mnt/rootfs.cpio"
        cmd += f" --cpus {kvm_nproc}"
        cmd += " --mem 320M"
        cmd += " --console virtio"
        cmd += " --irqchip gicv3"
        cmd += f" --params {kvm_karg}"

        # We use qemu.sendline() to run the command because the
        # program will not return an exit code. The command "lkvm run"
        # will spawn the new virtual machine console. The login is
        # expected to be reached after the command is issued.
        self.emulator.qemu.sendline(cmd)

        # We login in the virtual machine.
        self.emulator.login()

        # We check we can see our kernel argument.
        out, ret = self.emulator.run("cat /proc/cmdline")
        self.assertEqual(ret, 0)
        self.assertIn(kvm_karg, out[0])

        # We check the virtual machine has the expected number of CPU.
        out, ret = self.emulator.run("nproc")
        self.assertEqual(ret, 0)
        self.assertEqual(int(out[0]), kvm_nproc)

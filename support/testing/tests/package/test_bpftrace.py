import os

import infra.basetest


# gitlab-runner: 2xlarge
class TestBpftrace(infra.basetest.BRTest):
    kern_fragment = infra.filepath(
        "tests/package/test_bpftrace/linux-bpftrace.fragment"
    )
    config = f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.32"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_fragment}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_BPFTRACE=y
        BR2_PACKAGE_TAR=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="256M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        drive = os.path.join(self.builddir, "images", "rootfs.ext4")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(
            arch="aarch64",
            kernel=kern,
            kernel_cmdline=["root=/dev/vda console=ttyAMA0"],
            options=[
                "-M", "virt",
                "-cpu", "cortex-a57",
                "-m", "256M",
                "-drive", f"file={drive},if=virtio,format=raw"
            ]
        )
        self.emulator.login()

        self.assertRunOk("mount -t debugfs none /sys/kernel/debug/")

        # Check the program can run.
        self.assertRunOk("bpftrace --version")

        # Check that bpftrace can find a syscall tracepoint.
        self.assertRunOk("bpftrace -l 'tracepoint:syscalls:sys_enter_execve'")

        # Compile and attach a tracepoint program, then trigger it with the
        # command executed by bpftrace. The marker avoids matching volatile
        # fields such as PIDs or command names.
        cmd = (
            "bpftrace -e 'tracepoint:syscalls:sys_enter_execve "
            '{ printf("buildroot-bpftrace-test\\n"); exit(); }\' '
            "-c /bin/true"
        )
        output, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertIn("buildroot-bpftrace-test", "\n".join(output))

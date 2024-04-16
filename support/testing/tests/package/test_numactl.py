import os
import re

import infra.basetest


class TestNumaCtl(infra.basetest.BRTest):
    # A specific configuration is needed for testing numactl:
    # - This test uses a x86_64 config, which has mature NUMA support.
    # - A kernel need to compiled with a NUMA support.
    kernel_fragment = \
        infra.filepath("tests/package/test_numactl/linux-numactl.fragment")
    config = \
        f"""
        BR2_x86_64=y
        BR2_x86_corei7=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.75"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/x86_64/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kernel_fragment}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF=y
        BR2_PACKAGE_NUMACTL=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def check_numactl_preferred(self):
        # Show the default NUMA policy settings. We check we have the
        # 4 physical cpus on 2 nodes we configured the emulator
        # command line.
        out, ret = self.emulator.run("numactl --show")
        self.assertEqual(ret, 0)
        checks = [
            "policy: default",
            "preferred node: current",
            "physcpubind: 0 1 2 3 ",
            "nodebind: 0 1 ",
            "membind: 0 1 "
        ]
        for pattern in checks:
            self.assertIn(pattern, out)

        # Check the preferred policy on different nodes. This command
        # is taken from the numactl man page.
        for pref_node in range(2):
            cmd = f"numactl --preferred={pref_node} numactl --show"
            out, ret = self.emulator.run(cmd)
            self.assertEqual(ret, 0)
            checks = [
                "policy: preferred",
                f"preferred node: {pref_node}"
            ]
            for pattern in checks:
                self.assertIn(pattern, out)

    def get_numa_node_free_mem(self):
        out, ret = self.emulator.run("numactl --hardware")
        self.assertEqual(ret, 0)
        free_mem = {}
        p = re.compile("^node ([0-9]+) free: ([0-9]+) MB")
        for line in out:
            m = p.match(line)
            if m:
                node = int(m.group(1))
                mem = int(m.group(2))
                free_mem[node] = mem
        return free_mem

    def check_numactl_membind(self):
        # We get the current amount of free memory on each node, for
        # later comparison.
        initial_node_free_mem = self.get_numa_node_free_mem()

        # We allocate a shared memory file with a restriction to be in
        # node 1 memory only.
        shm_file = "/dev/shm/file"
        file_size = 100
        cmd = f"numactl --membind=1 dd if=/dev/zero of={shm_file} bs=1M count={file_size}"
        self.assertRunOk(cmd)

        # We collect again the amount of free memory per node.
        node_free_mem = self.get_numa_node_free_mem()

        # Since we allocated 100M on node 1 only, we check the free
        # space on node 0 did not significantly changed and on node 1
        # approximately reduced of the file size.
        diff = initial_node_free_mem[0] - node_free_mem[0]
        self.assertAlmostEqual(diff, 0, delta=10)
        diff = initial_node_free_mem[1] - node_free_mem[1]
        self.assertAlmostEqual(diff, file_size, delta=10)

        # Remove the file, to free the memory.
        self.assertRunOk(f"rm -f {shm_file}")

        # We allocate again a file in shared memory, but this time in
        # two chunks. Each chunk is requested to be allocated in two
        # different nodes. This example is taken from the numactl man
        # page.
        chunk_size = file_size // 2
        cmd = "numactl --membind=0 "
        cmd += f"dd if=/dev/zero of={shm_file} bs=1M count={chunk_size}"
        self.assertRunOk(cmd)
        cmd = "numactl --membind=1 "
        cmd += f"dd if=/dev/zero of={shm_file} bs=1M count={chunk_size} seek={chunk_size}"
        self.assertRunOk(cmd)

        # We collect again the amount of free memory.
        node_free_mem = self.get_numa_node_free_mem()

        # We check the free memory space approximately reduced of each
        # chunk size.
        for node in range(2):
            free_mem_diff = initial_node_free_mem[node] - node_free_mem[node]
            self.assertAlmostEqual(free_mem_diff, chunk_size, delta=5)

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "bzImage")
        # We start the Qemu emulator with 4 processors on 2 NUMA nodes.
        self.emulator.boot(arch="x86_64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyS0"],
                           options=["-cpu", "Nehalem", "-m", "512M",
                                    "-smp", "cpus=4,sockets=2,cores=2,maxcpus=4",
                                    "-object", "memory-backend-ram,size=256M,id=m0",
                                    "-object", "memory-backend-ram,size=256M,id=m1",
                                    "-numa", "node,cpus=0-1,nodeid=0,memdev=m0",
                                    "-numa", "node,cpus=2-3,nodeid=1,memdev=m1",
                                    "-initrd", img])
        self.emulator.login()

        # Check a simple numactl invication:
        # show the NUMA hardware inventory.
        self.assertRunOk("numactl --hardware")

        self.check_numactl_preferred()
        self.check_numactl_membind()

import infra.basetest
import json
import os


class PodmanBase(infra.basetest.BRTest):
    config = \
        """
        BR2_arm=y
        BR2_cortex_a9=y
        BR2_ARM_ENABLE_VFP=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PER_PACKAGE_DIRECTORIES=y
        BR2_SYSTEM_DHCP="eth0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.10.202"
        BR2_LINUX_KERNEL_DEFCONFIG="vexpress"
        BR2_LINUX_KERNEL_DTS_SUPPORT=y
        BR2_LINUX_KERNEL_INTREE_DTS_NAME="vexpress-v2p-ca9"
        BR2_PACKAGE_PODMAN=y
        BR2_PACKAGE_UTIL_LINUX=y
        BR2_PACKAGE_UTIL_LINUX_MOUNT=y
        BR2_PACKAGE_HOST_GO_BIN=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="256M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def do_test(self):
        class _Emul():
            def __init__(self, orig_emulator):
                self.emulator = orig_emulator

            def run(self, cmd, timeout=-1):
                if timeout < 0:
                    timeout = 60
                return self.emulator.run(cmd, timeout)

            def stop(self):
                self.emulator.stop()

        kernel_file = os.path.join(self.builddir, 'images', 'zImage')
        dtb_file = os.path.join(self.builddir, 'images', 'vexpress-v2p-ca9.dtb')
        ext2_file = os.path.join(self.builddir, 'images', 'rootfs.ext2')
        self.emulator.boot(
            arch='armv5',
            kernel=kernel_file,
            kernel_cmdline=[
                'root=/dev/mmcblk0',
                'rootwait',
                'console=ttyAMA0',
            ],
            options=[
                '-M', 'vexpress-a9',
                '-dtb', dtb_file,
                '-drive', f'file={ext2_file},if=sd,format=raw',
            ]
        )
        self.emulator.login()

        # Trick: replace the original emulator with one that always
        # adds a timeout
        self.emulator = _Emul(self.emulator)

        # Do some preparation for rootless use
        self.assertRunOk("mount --make-shared /")
        self.assertRunOk("chmod 666 /dev/net/tun")
        self.assertRunOk("useradd -d /home/foo -m -s /bin/sh -u 1000 foo")
        self.assertRunOk("touch /etc/subuid /etc/subgid")
        self.assertRunOk("usermod --add-subuids 10000-75535 foo")
        self.assertRunOk("usermod --add-subgids 10000-75535 foo")

        # First, test podman as root (the current user)
        self.do_podman()

        # Now, test podman as non-root. We need a bit of setup
        # We need to use the same prompts for the user as used for root, so that the
        # REPLWrapper still detects the prompts. This means it is going to be a bit
        # difficut to directly see that it was a user that executed a command.
        self.assertRunOk('su -s /usr/bin/env - foo PS1="${PS1}" PS2="${PS2}" /bin/sh')
        output, _ = self.emulator.run("id -u")
        self.assertEqual(output[0], "1000", "Could not switch to non-root")
        self.do_podman()

    def do_podman(self):
        # The podman binary is huge, so it takes time to load...
        # Next calls will be faster, though, as it is going to be cached.
        self.assertRunOk('podman --version')

        # Check for an empty image store
        output, exit_code = self.emulator.run("podman image ls --format '{{ json }}'")
        img_info = json.loads("".join(output))
        self.assertEqual(len(img_info), 0, f"{len(img_info)} image(s) already present")

        # Pull an image; it can take time: network, hash checksums...
        self.assertRunOk('podman image pull busybox:1.37.0')
        output, exit_code = self.emulator.run("podman image ls --format '{{ json }}'")
        img_info = json.loads("".join(output))
        self.assertEqual(len(img_info), 1, f"{len(img_info)} image(s), expecting 1")
        self.assertTrue("Id" in img_info[0], '"Id" not in img_info[0]')
        self.assertTrue("Digest" in img_info[0], '"Digest" not in img_info[0]')
        self.assertEqual(img_info[0]["Names"][0], "docker.io/library/busybox:1.37.0")

        output, _ = self.emulator.run('echo ${br_container}')
        self.assertEqual(output[0], "", "Already in a container")

        # Spawn the container; that can take a bit of time
        # Propagate the prompt so that the REPLWrapper detects it
        self.assertRunOk(
            "podman container run --rm -ti -e PS1 -e br_container=podman busybox:1.37.0",
        )
        # Twist! The command above is still running, but the shell it
        # started exposes the same prompt we expect. This is all what we want.
        output, _ = self.emulator.run('echo ${br_container}')
        self.assertEqual(output[0], "podman", "Not in a podman container")

        # Check that pid1 is the shell
        output, _ = self.emulator.run('readlink /proc/1/exe')
        self.assertEqual(output[0], "/bin/sh", f"PID1 is {output[0]}, should be /bin/sh")

        # Try to get something off the network
        # Using http, not https, as busybox' wget does not do https
        # Using --spider to just check we can reach the remote.
        output, exit_code = self.emulator.run('wget --spider http://google.com/')
        self.assertEqual(exit_code, 0, "wget did not succeed to reach google.com")
        self.assertEqual(output[-1], "remote file exists", "wget did not succeed to reach google.com")

        # Exit the container
        self.assertRunOk("exit 0")
        # Twist, take two! We are now back to the shell in the VM.
        output, _ = self.emulator.run('echo ${br_container}')
        self.assertEqual(output[0], "", "Still in a container")

        # Spawn a container, round two, but with an injected init this time
        self.assertRunOk(
            "podman container run --rm -ti -e PS1 --init -e br_container=podman busybox:1.37.0",
        )
        output, _ = self.emulator.run('echo ${br_container}')
        self.assertEqual(output[0], "podman", "Not in a podman container")

        # Check that pid1 is the init injected by podman
        output, _ = self.emulator.run('readlink /proc/1/exe')
        self.assertEqual(output[0], "/run/podman-init", f"PID1 is {output[0]}, should be /run/podman-init")

        # Exit the container
        self.assertRunOk("exit 0")
        output, _ = self.emulator.run('echo ${br_container}')
        self.assertEqual(output[0], "", "Still in a container")

        # Use an image from another registry, spawn without pulling first
        self.assertRunOk(
            "podman container run --rm -ti -e PS1 -e br_container=podman quay.io/prometheus/busybox:latest",
        )
        output, _ = self.emulator.run('echo ${br_container}')
        self.assertEqual(output[0], "podman", "Not in a podman container")
        self.assertRunOk("exit 0")
        output, _ = self.emulator.run('echo ${br_container}')
        self.assertEqual(output[0], "", "Still in a container")

        # Test networking between two containers
        self.assertRunOk("podman network create buz")
        self.assertRunOk(
            "podman container run --rm -ti --name pod007 --network buz --detach busybox:1.37.0",
        )
        self.assertRunOk(
            "podman container run --rm -ti --name pod006 --network buz --detach busybox:1.37.0",
        )
        # Ensure each pod can resolv itself and the other
        # (not using itertools.matrix() just for those trivial combinations)
        for pod1, pod2 in [
            ("pod006", "pod006"),
            ("pod006", "pod007"),
            ("pod007", "pod007"),
            ("pod007", "pod006"),
        ]:
            output, exit_code = self.emulator.run(
                f"podman container exec {pod1} nslookup {pod2}",
            )
            self.assertEqual(exit_code, 0)
            self.assertTrue(output[0].startswith("Server:"))
            self.assertTrue(output[1].startswith("Address:"))
            # Busybox' nslookup emits one "Non-authoritative answer" per
            # supported address familly: IPv4 and IPv6.
            self.assertEqual(
                len([line for line in output[2:] if line == "Non-authoritative answer:"]),
                2,
            )
            # But only IPv4 is available on this network
            self.assertEqual(
                len([line for line in output[2:] if line.startswith("Address:")]),
                1,
            )
        self.assertRunOk("podman container kill --all")
        output, _ = self.emulator.run("podman container ls --format '{{ json }}'")
        pod_info = json.loads("".join(output))
        self.assertEqual(len(pod_info), 0, f"{len(pod_info)} container(s) still present, expecting 0")

        # Remove the offical image
        self.assertRunOk('podman image rm busybox:1.37.0')
        output, _ = self.emulator.run("podman image ls --format '{{ json }}'")
        img_info = json.loads("".join(output))
        # There is still one image(the unofficial one from quay.io)
        self.assertEqual(len(img_info), 1, f"{len(img_info)} image(s) still present, expecting 1")

        # Remove all remaining images
        self.assertRunOk('podman image prune -af')
        output, exit_code = self.emulator.run("podman image ls --format '{{ json }}'")
        img_info = json.loads("".join(output))
        self.assertEqual(len(img_info), 0, f"{len(img_info)} image(s) still present, expecting 0")


class TestPodmanIptables(PodmanBase):
    def test_run(self):
        self.do_test()


class TestPodmanNftables(PodmanBase):
    config = PodmanBase.config + """
    BR2_PACKAGE_NFTABLES=y
    """

    def test_run(self):
        self.do_test()


class TestPodmanTini(PodmanBase):
    config = PodmanBase.config + """
    BR2_PACKAGE_PODMAN_INIT_TINI=y
    """

    def test_run(self):
        self.do_test()


class TestPodmanSlirpIptables(PodmanBase):
    config = PodmanBase.config + """
    BR2_PACKAGE_PODMAN_NET_SLIRP4NETNS=y
    """

    def test_run(self):
        self.do_test()


class TestPodmanSlirpNftables(PodmanBase):
    config = PodmanBase.config + """
    BR2_PACKAGE_NFTABLES=y
    BR2_PACKAGE_PODMAN_NET_SLIRP4NETNS=y
    """

    def test_run(self):
        self.do_test()

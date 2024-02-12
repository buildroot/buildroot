import os

import infra.basetest


class TestGit(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_GIT=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute.
        self.assertRunOk("git --version")

        # Initialize some git global configuration.
        git_cfg = [
            ("user.name", "Build Root"),
            ("user.email", "build.root@localhost.localdomain"),
            ("color.ui", "false"),
            ("init.defaultBranch", "master"),
            ("core.pager", "")
        ]
        for cfg_name, cfg_value in git_cfg:
            cmd = f"git config --global {cfg_name} '{cfg_value}'"
            self.assertRunOk(cmd)

        # Run a sequence of few git commands.
        commands = [
            "mkdir workdir",
            "cd workdir",
            "git init",
            "echo 'Hello World' > file.txt",
            "git add file.txt",
            "git commit -as -m 'Initial commit'",
            "git checkout -b my_branch",
            "sed -i 's/World/Buildroot/g' file.txt",
            "git status",
            "git commit -as -m 'Replace World by Buildroot'",
            "git format-patch -M -n -s -o patches master",
            "ls -al patches/*.patch",
            "git checkout -b another_branch master",
            "git am patches/*.patch",
            "git diff --exit-code my_branch another_branch",
            "git tag -a -m 'Tagged v1.0' v1.0",
            "git log"
        ]
        for cmd in commands:
            self.assertRunOk(cmd)

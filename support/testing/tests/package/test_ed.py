import os

import infra.basetest


class TestEd(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_ED=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def run_ed_cmds(self, ed_cmds):
        cmd = "ed <<EOF\n"
        cmd += "\n".join(ed_cmds)
        cmd += "\nEOF"
        self.assertRunOk(cmd)

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the program can run. This also check we have the
        # actual GNU ed, rather than the Busybox ed, which does not
        # recognize the --version option.
        self.assertRunOk("ed --version")

        test_fname = "test.txt"
        input_text_lines = [
            "Hello World",
            "Embedded Linux is Hard."
        ]
        output_expected_text = [
            "Hello Buildroot",
            "---------------",
            "Making Embedded Linux Easy."
        ]

        # We define few "ed" command sequences, creating and editing a
        # text file. The final output of this sequence is expected to
        # match the expected text previously defined.
        create_file = ["a"]
        create_file += input_text_lines
        create_file += [
            ".",
            f"w {test_fname}",
            "q"
        ]

        edit_file = [
            f"r {test_fname}",
            "1",
            "s/World/Buildroot/",
            "2",
            "s/is Hard/Easy/",
            "s/^/Making /",
            "w",
            "q"
        ]

        insert_txt = [
            f"r {test_fname}",
            "2",
            "i",
            "This is a new line",
            ".",
            "w",
            "q"
        ]

        change_txt = [
            f"r {test_fname}",
            "2",
            "c",
            "---------------",
            ".",
            "w"
            "q"
        ]

        # We execute all "ed" command batches.
        ed_cmd_batches = [
            create_file,
            edit_file,
            insert_txt,
            change_txt
        ]
        for ed_cmd_batch in ed_cmd_batches:
            self.run_ed_cmds(ed_cmd_batch)

        # The final test file should contain the expected text.
        out, ret = self.emulator.run(f"cat {test_fname}")
        self.assertEqual(ret, 0)
        self.assertEqual(out, output_expected_text)

import os

import infra.basetest


class TestScreen(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_SCREEN=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        session_name = "BuildrootSession"
        message = "HelloBuildroot"
        screen_dump = "screen.dump.txt"

        # Check the program can execute
        self.assertRunOk("screen --version")

        # There is no "screen" running yet. Listing sessions is
        # expected to fail.
        _, exit_code = self.emulator.run("screen -ls")
        self.assertNotEqual(exit_code, 0)

        # We now start a detached and named session.
        self.assertRunOk(f"screen -dmS {session_name}")

        # Since we are supposed to have a running session, it should
        # appear in the list.
        output, exit_code = self.emulator.run("screen -ls")
        self.assertEqual(exit_code, 0)
        self.assertIn(session_name, "\n".join(output))

        # We send an exec command to print a message in the "screen"
        # display running in background.
        cmd = f"screen -S {session_name} -X exec printf {message}"
        self.assertRunOk(cmd)

        # We request a hardcopy of this "screen" display.
        cmd = f"screen -S {session_name} -X hardcopy {screen_dump}"
        self.assertRunOk(cmd)

        # The dump file is supposed to contain our message.
        self.assertRunOk(f"grep -Fo '{message}' {screen_dump}")

        # We request "screen" to quit...
        cmd = f"screen -S {session_name} -X quit"
        self.assertRunOk(cmd)

        # Since the session is supposed to be terminated, listing
        # sessions is expected to fail (again).
        _, exit_code = self.emulator.run("screen -ls")
        self.assertNotEqual(exit_code, 0)

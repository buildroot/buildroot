class GraphicsBase:
    def get_n_fb_crc(self, *, count=10, uniq=False, timeout=-1):
        """
        Return count DRM CRC from the framebuffer. If uniq is True,
        only unique CRCs are returned (which may be less than the
        requested cont).
        Returns a possibly empty list of integers.
        Set timeout to -1 for no timeout, or to a positive number for
        a timeout of that many seconds.
        """
        # DRM CRCs are exposed through a sysfs pseudo file
        try:
            self.debugfs_mounted
        except AttributeError:
            # Note: some init system (e.g. systemd) may have this already
            # mounted, so check beforehand
            self.assertRunOk("mountpoint /sys/kernel/debug/ || mount -t debugfs none /sys/kernel/debug/")
            self.debugfs_mounted = True

        # The first column is the frame number, the second column is the
        # CRC measure. We use "head" to get the needed CRC count.
        disp_crc_path = "/sys/kernel/debug/dri/0/crtc-0/crc/data"
        cmd = f"head -{count} {disp_crc_path}"

        # The DRM CRC sysfs pseudo file lines are terminated by '\n'
        # and '\0'. We remove the '\0' to have a text-only output.
        cmd += " | tr -d '\\000'"

        # Finally, we drop the frame counter, and keep only the second
        # column (CRC values)
        cmd += " | cut -f 2 -d ' '"

        if uniq:
            cmd += " | sort -u"

        output, exit_code = self.emulator.run(cmd, timeout=timeout)
        self.assertTrue(exit_code == 0, f"'{cmd}' failed with exit code {exit_code}")

        return [int(crc, 16) for crc in output]

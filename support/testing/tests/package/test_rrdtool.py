import os

import infra.basetest


class TestRRDTool(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_RRDTOOL=y
        BR2_PACKAGE_RRDTOOL_RRDGRAPH=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the program can run.
        self.assertRunOk("rrdtool --version")

        # This test sequence is inspired from parts of the RRDTool
        # tutorial:
        # https://oss.oetiker.ch/rrdtool/tut/rrdtutorial.en.html

        rrd_file = "test.rrd"
        data_source = "speed"

        cmd = f"rrdtool create {rrd_file}"
        cmd += " --start 920804400"
        cmd += f" DS:{data_source}:COUNTER:600:U:U"
        cmd += " RRA:AVERAGE:0.5:1:24"
        cmd += " RRA:AVERAGE:0.5:6:10"
        self.assertRunOk(cmd)

        # Some data to fill in our database, from the tutorial page.
        data = [12345, 12357, 12363, 12363, 12363,
                12373, 12383, 12393, 12399, 12405,
                12411, 12415, 12420, 12422, 12423]
        timestamp = 920804700  # timestamp of: Sun Mar  7 12:05:00 PM CET 1999

        # We check we can put our data in the database. We start at
        # our timestamp, then increase by 5 minutes.
        for d in data:
            cmd = f"rrdtool update {rrd_file} {timestamp}:{d}"
            timestamp += 300
            self.assertRunOk(cmd)

        # We check we can read back our data.
        cmd = f"rrdtool fetch {rrd_file}"
        cmd += " AVERAGE --start 920804400 --end 920809200"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0].strip(), data_source)
        # We check that at time=920805600 we have speed=0.
        data_line = next(ln for ln in out if ln.strip().startswith('920805600:'))
        speed = float(data_line.split(':')[1])
        self.assertAlmostEqual(speed, 0.)

        # We generate a first simple image graph.
        cmd = "rrdtool graph speed.png"
        cmd += " --start 920804400 --end 920808000"
        cmd += f" DEF:myspeed={rrd_file}:{data_source}:AVERAGE"
        cmd += " LINE2:myspeed#FF0000"
        self.assertRunOk(cmd, timeout=20)

        # We check the output file exists and has a size
        # greater than zero.
        self.assertRunOk("test -s speed.png")

        # We generate a slightly more complex graph.
        cmd = "rrdtool graph speed2.png"
        cmd += " --start 920804400 --end 920808000"
        cmd += " --vertical-label m/s"
        cmd += f" DEF:myspeed={rrd_file}:{data_source}:AVERAGE"
        cmd += " CDEF:realspeed=myspeed,1000,\\*"
        cmd += " LINE2:realspeed#FF0000"
        self.assertRunOk(cmd, timeout=20)

        # Again, we check the output file exists.
        self.assertRunOk("test -s speed2.png")

        # Finally, we generate the last graph, with some rules.
        cmd = "rrdtool graph speed3.png"
        cmd += " --start 920804400 --end 920808000"
        cmd += " --vertical-label km/h"
        cmd += f" DEF:myspeed={rrd_file}:{data_source}:AVERAGE"
        cmd += " \"CDEF:kmh=myspeed,3600,*\""
        cmd += " CDEF:fast=kmh,100,GT,kmh,0,IF"
        cmd += " CDEF:good=kmh,100,GT,0,kmh,IF"
        cmd += " HRULE:100#0000FF:\"Maximum allowed\""
        cmd += " AREA:good#00FF00:\"Good speed\""
        cmd += " AREA:fast#FF0000:\"Too fast\""
        self.assertRunOk(cmd, timeout=20)

        # And again, we check the output file exists.
        self.assertRunOk("test -s speed3.png")

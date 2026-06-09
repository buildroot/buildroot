import unittest
import os
import dataclasses
import datetime
import json
from typing import ClassVar

from infra.builder import Builder
from infra.emulator import Emulator

BASIC_TOOLCHAIN_CONFIG = \
    """
    BR2_arm=y
    BR2_TOOLCHAIN_EXTERNAL=y
    BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
    BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_ARMV5_EABI_GLIBC_STABLE=y
    """

MINIMAL_CONFIG = \
    """
    BR2_INIT_NONE=y
    BR2_SYSTEM_BIN_SH_NONE=y
    # BR2_PACKAGE_BUSYBOX is not set
    # BR2_TARGET_ROOTFS_TAR is not set
    """


@dataclasses.dataclass
class BRTestSettings:
    """support/testing/run-tests stores runtime settings in this
    object, and serializes it into the environment variable named in
    CONF_ENV. On instantiation, BRConfigTest loads this
    configuration. That way configuration can be transferred into
    multiprocessing worker processes without requiring the "fork"
    start method.

    """
    CONF_ENV: ClassVar[str] = 'BR_TEST_CONFIG_JSON'

    downloaddir: str
    outputdir: str
    logtofile: bool = True
    keepbuilds: bool = False
    jlevel: int = 0
    timeout_multiplier: int = 1

    def to_env(self) -> None:
        os.environ[self.CONF_ENV] = json.dumps(dataclasses.asdict(self))

    @classmethod
    def from_env(cls) -> 'BRTestSettings':
        return cls(**json.loads(os.environ[cls.CONF_ENV]))


class BRConfigTest(unittest.TestCase):
    """Test up to the configure stage."""
    config: str
    br2_external: list[str] = list()
    downloaddir = None
    outputdir = None
    logtofile = True
    keepbuilds = False
    jlevel = 0
    timeout_multiplier = 1

    def __init__(self, names):
        super(BRConfigTest, self).__init__(names)
        if BRTestSettings.CONF_ENV in os.environ:
            self.conf_from_env()
        self.testname = self.__class__.__name__
        self.builddir = self.outputdir and os.path.join(self.outputdir, self.testname)
        self.config += '\nBR2_DL_DIR="{}"\n'.format(self.downloaddir)
        self.config += "\nBR2_JLEVEL={}\n".format(self.jlevel)

    def show_msg(self, msg):
        print("{} {:40s} {}".format(datetime.datetime.now().strftime("%H:%M:%S"),
                                    self.testname, msg))

    def conf_from_env(self) -> None:
        conf = BRTestSettings.from_env()
        for f in dataclasses.fields(conf):
            setattr(self, f.name, getattr(conf, f.name))

    def setUp(self):
        self.show_msg("Starting")
        self.b = Builder(self.config, self.builddir, self.logtofile, self.jlevel)

        if not self.keepbuilds:
            self.b.delete()

        if not self.b.is_finished():
            self.b.configure(make_extra_opts=["BR2_EXTERNAL={}".format(":".join(self.br2_external))])

    def tearDown(self):
        self.show_msg("Cleaning up")
        if self.b and not self.keepbuilds:
            self.b.delete()


class BRHostPkgTest(BRConfigTest):
    """Test up to the build stage of a host package. Define hostpkgs in
    the class to the list of host packages that should be built."""
    config = \
        BASIC_TOOLCHAIN_CONFIG + \
        MINIMAL_CONFIG
    hostpkgs = None

    def __init__(self, names):
        super(BRHostPkgTest, self).__init__(names)

    def setUp(self):
        super(BRHostPkgTest, self).setUp()
        if not self.b.is_finished():
            self.show_msg("Building")
            self.b.build(make_extra_opts=self.hostpkgs)
            self.show_msg("Building done")

    def tearDown(self):
        super(BRHostPkgTest, self).tearDown()


class BRTest(BRConfigTest):
    """Test up to the build stage and instantiate an emulator."""
    def __init__(self, names):
        super(BRTest, self).__init__(names)
        self.emulator = None

    def setUp(self):
        super(BRTest, self).setUp()
        if not self.b.is_finished():
            self.show_msg("Building")
            self.b.build()
            self.show_msg("Building done")

        self.emulator = Emulator(self.builddir, self.downloaddir,
                                 self.logtofile, self.timeout_multiplier)

    def tearDown(self):
        if self.emulator:
            self.emulator.stop()
        super(BRTest, self).tearDown()

    # Run the given 'cmd' with a 'timeout' on the target and
    # assert that the command succeeded; on error, print the
    # faulty command and its output
    def assertRunOk(self, cmd, timeout=-1):
        out, exit_code = self.emulator.run(cmd, timeout)
        self.assertEqual(
            exit_code,
            0,
            "\nFailed to run: {}\noutput was:\n{}".format(cmd, '  '+'\n  '.join(out))
        )

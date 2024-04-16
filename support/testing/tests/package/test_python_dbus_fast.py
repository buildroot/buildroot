import textwrap


from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3DBusFast(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_DBUS=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_DBUS_FAST=y
        """
    sample_scripts = ["tests/package/sample_python_dbus_fast.py"]

    def run_sample_scripts(self):
        config = \
            """
            <!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
             "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
            <busconfig>
              <policy user="root">
                <allow own="dbus.fast.sample"/>
                <allow send_destination="dbus.fast.sample"/>
              </policy>
            </busconfig>
            """
        config = textwrap.dedent(config)
        config_dir = "/etc/dbus-1/system.d"
        config_fn = "dbus.fast.sample.conf"

        # Setup and reload D-Bus configuration
        self.emulator.run("mkdir -p " + config_dir)
        self.emulator.run("cat > " + config_dir + "/" + config_fn +
                          " <<EOF" + config + "EOF")
        self.emulator.run("killall -SIGHUP dbus-daemon")

        # Run test scripts
        super().run_sample_scripts()

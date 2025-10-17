from tests.package.test_python import TestPythonPackageBase


class TestPythonSCP(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_DROPBEAR=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_SCP=y
        """
    sample_scripts = ["tests/package/sample_python_scp.py"]

    def run_sample_scripts(self):
        # Allow passwordless root login in SSH server
        self.assertRunOk("mkdir -m 0700 /root/.ssh")
        self.assertRunOk("dropbearkey -t ed25519 -f .ssh/id_dropbear")
        self.assertRunOk("dropbearkey -y -f .ssh/id_dropbear | grep '^ssh-ed25519' > .ssh/authorized_keys")
        self.assertRunOk("dropbearconvert dropbear openssh .ssh/id_dropbear .ssh/id_ed25519")

        super().run_sample_scripts()

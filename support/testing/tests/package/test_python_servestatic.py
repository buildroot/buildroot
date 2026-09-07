from tests.package.test_python import TestPythonPackageBase


class TestPythonServeStatic(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_SERVESTATIC=y
        """

    sample_scripts = ["tests/package/sample_python_servestatic.py"]

    def run_sample_scripts(self):
        self.assertRunOk(
            "servestatic --help | grep -q 'Process static files'"
        )

        super().run_sample_scripts()

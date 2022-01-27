import infra
from tests.package.test_python import TestPythonPackageBase


class TestPythonPybind (TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_PYBIND_EXAMPLE=y
        """
    sample_scripts = ["tests/package/sample_python_pybind.py"]
    # ship examples macro & installs it to host
    br2_external = [infra.filepath("tests/package/br2-external/python-pybind")]

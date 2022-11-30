from tests.package.test_python import TestPythonPackageBase
import os


class TestPythonPy3UnitTestXmlReporting(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_UNITTEST_XML_REPORTING=y
        """
    sample_scripts = ["tests/package/sample_python_unittest_xml_reporting.py"]
    timeout = 60

    def test_run(self):
        self.login()
        self.check_sample_scripts_exist()
        cmd = "%s %s" % (self.interpreter, os.path.basename(self.sample_scripts[0]))
        self.assertRunOk(cmd)
        # check if some tests results in XML were generated
        cmd = "ls -1 test-reports/TEST-Test1-*.xml"
        self.assertRunOk(cmd)

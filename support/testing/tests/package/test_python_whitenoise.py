import time

from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Whitenoise(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_DJANGO=y
        BR2_PACKAGE_PYTHON_WHITENOISE=y
        BR2_PACKAGE_PYTHON3_SQLITE=y
        """

    def test_run(self):
        self.login()
        timeout = 35

        cmd = "cd /opt && /usr/bin/django-admin startproject testsite"
        self.assertRunOk(cmd, timeout=timeout)
        # STATIC_ROOT needs to be set for 'collectstatic' to work.
        self.emulator.run("echo 'STATIC_ROOT = BASE_DIR / \"staticfiles\"' >> /opt/testsite/testsite/settings.py")
        cmd = "cd /opt/testsite && " + self.interpreter + " ./manage.py collectstatic"
        self.assertRunOk(cmd, timeout=timeout)
        # whitenoise docs say it needs to be added directly after SecurityMiddleware, so we do this here with sed.
        cmd = """sed -i -e /django.middleware.security.SecurityMiddleware/a\\ \\"whitenoise.middleware.WhiteNoiseMiddleware\\",\
        /opt/testsite/testsite/settings.py"""
        self.assertRunOk(cmd, timeout=timeout)
        # --nostatic ensures the builtin django server doesn't serve the static files,
        # so we can test that whitenoise serves them
        cmd = "cd /opt/testsite && " + self.interpreter + " ./manage.py runserver --nostatic 0.0.0.0:1234 > /dev/null 2>&1 & "
        self.assertRunOk(cmd, timeout=timeout)
        # give some time to setup the server
        for attempt in range(30 * self.emulator.timeout_multiplier):
            time.sleep(1)
            cmd = "wget http://127.0.0.1:1234/static/admin/css/base.css"
            _, exit_code = self.emulator.run(cmd)
            if exit_code == 0:
                break
        self.assertEqual(exit_code, 0, "Timeout while waiting for django server")

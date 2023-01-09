################################################################################
#
# python-crontab
#
################################################################################

PYTHON_CRONTAB_VERSION = 2.7.1
PYTHON_CRONTAB_SITE = https://files.pythonhosted.org/packages/6a/b6/94d861e868698b8e3f288f7e4684e30535b0d9a6b38316ee0a3d4d31e6ae
PYTHON_CRONTAB_SETUP_TYPE = setuptools
PYTHON_CRONTAB_LICENSE = LGPL-3.0+
PYTHON_CRONTAB_LICENSE_FILES = COPYING

$(eval $(python-package))

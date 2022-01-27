################################################################################
#
# python-pytz
#
################################################################################

PYTHON_PYTZ_VERSION = 2021.3
PYTHON_PYTZ_SOURCE = pytz-$(PYTHON_PYTZ_VERSION).tar.gz
PYTHON_PYTZ_SITE = https://files.pythonhosted.org/packages/e3/8e/1cde9d002f48a940b9d9d38820aaf444b229450c0854bdf15305ce4a3d1a
PYTHON_PYTZ_SETUP_TYPE = setuptools
PYTHON_PYTZ_LICENSE = MIT
PYTHON_PYTZ_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

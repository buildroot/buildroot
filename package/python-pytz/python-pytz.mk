################################################################################
#
# python-pytz
#
################################################################################

PYTHON_PYTZ_VERSION = 2026.4
PYTHON_PYTZ_SOURCE = pytz-$(PYTHON_PYTZ_VERSION).tar.gz
PYTHON_PYTZ_SITE = https://files.pythonhosted.org/packages/b0/ed/fa23d28713004418bbf2407127f80f385bfb0bf4e677bef02c25c27b00ee
PYTHON_PYTZ_SETUP_TYPE = setuptools
PYTHON_PYTZ_LICENSE = MIT
PYTHON_PYTZ_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
$(eval $(host-python-package))

################################################################################
#
# python-serialx
#
################################################################################

PYTHON_SERIALX_VERSION = 1.15.0
PYTHON_SERIALX_SOURCE = serialx-$(PYTHON_SERIALX_VERSION).tar.gz
PYTHON_SERIALX_SITE = https://files.pythonhosted.org/packages/1d/5f/d1496ad01c310ae573921ca24c62bfaad9ff34cf16c583f4ae85f39b77e9
PYTHON_SERIALX_SETUP_TYPE = setuptools
PYTHON_SERIALX_LICENSE = Apache-2.0
PYTHON_SERIALX_LICENSE_FILES = LICENSE
PYTHON_SERIALX_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

################################################################################
#
# python-serialx
#
################################################################################

PYTHON_SERIALX_VERSION = 1.12.0
PYTHON_SERIALX_SOURCE = serialx-$(PYTHON_SERIALX_VERSION).tar.gz
PYTHON_SERIALX_SITE = https://files.pythonhosted.org/packages/c7/68/efe61ac6dd5fe536eba0a3a23e92d09caa9e78cc59f97bdeb594a0098ada
PYTHON_SERIALX_SETUP_TYPE = setuptools
PYTHON_SERIALX_LICENSE = Apache-2.0
PYTHON_SERIALX_LICENSE_FILES = LICENSE
PYTHON_SERIALX_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

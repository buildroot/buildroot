################################################################################
#
# python-serialx
#
################################################################################

PYTHON_SERIALX_VERSION = 1.11.0
PYTHON_SERIALX_SOURCE = serialx-$(PYTHON_SERIALX_VERSION).tar.gz
PYTHON_SERIALX_SITE = https://files.pythonhosted.org/packages/9b/c5/8c3f3e7985ca108fab641cc453ae015e1f6f15344064b99f115281c8bbdc
PYTHON_SERIALX_SETUP_TYPE = setuptools
PYTHON_SERIALX_LICENSE = Apache-2.0
PYTHON_SERIALX_LICENSE_FILES = LICENSE
PYTHON_SERIALX_DEPENDENCIES = host-python-setuptools-scm
PYTHON_SERIALX_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))

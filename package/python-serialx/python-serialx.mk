################################################################################
#
# python-serialx
#
################################################################################

PYTHON_SERIALX_VERSION = 1.14.0
PYTHON_SERIALX_SOURCE = serialx-$(PYTHON_SERIALX_VERSION).tar.gz
PYTHON_SERIALX_SITE = https://files.pythonhosted.org/packages/19/46/a23c683d997c5d46f34e777abb7f4b0e41e189b115a9f6995812e404595c
PYTHON_SERIALX_SETUP_TYPE = setuptools
PYTHON_SERIALX_LICENSE = Apache-2.0
PYTHON_SERIALX_LICENSE_FILES = LICENSE
PYTHON_SERIALX_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

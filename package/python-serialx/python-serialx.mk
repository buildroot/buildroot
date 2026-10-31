################################################################################
#
# python-serialx
#
################################################################################

PYTHON_SERIALX_VERSION = 1.15.1
PYTHON_SERIALX_SOURCE = serialx-$(PYTHON_SERIALX_VERSION).tar.gz
PYTHON_SERIALX_SITE = https://files.pythonhosted.org/packages/93/80/20ddfe87f1f62f604112def5bfc65673bd6013496201a6dfd8cc56f40366
PYTHON_SERIALX_SETUP_TYPE = setuptools
PYTHON_SERIALX_LICENSE = Apache-2.0
PYTHON_SERIALX_LICENSE_FILES = LICENSE
PYTHON_SERIALX_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

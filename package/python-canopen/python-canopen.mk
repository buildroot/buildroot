################################################################################
#
# python-canopen
#
################################################################################

PYTHON_CANOPEN_VERSION = 2.3.0
PYTHON_CANOPEN_SOURCE = canopen-$(PYTHON_CANOPEN_VERSION).tar.gz
PYTHON_CANOPEN_SITE = https://files.pythonhosted.org/packages/1a/b3/733e5f98c995d7f3e82853bc5ee2f0677df6203d51d8a4387af188322523
PYTHON_CANOPEN_SETUP_TYPE = setuptools
PYTHON_CANOPEN_LICENSE = MIT
PYTHON_CANOPEN_LICENSE_FILES = LICENSE.txt
PYTHON_CANOPEN_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

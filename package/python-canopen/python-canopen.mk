################################################################################
#
# python-canopen
#
################################################################################

PYTHON_CANOPEN_VERSION = 2.4.1
PYTHON_CANOPEN_SOURCE = canopen-$(PYTHON_CANOPEN_VERSION).tar.gz
PYTHON_CANOPEN_SITE = https://files.pythonhosted.org/packages/be/ea/f2654cb432988dfe9ab93140ff502f7e2e7eaa1835e8aaa4ee5a935af736
PYTHON_CANOPEN_SETUP_TYPE = setuptools
PYTHON_CANOPEN_LICENSE = MIT
PYTHON_CANOPEN_LICENSE_FILES = LICENSE.txt
PYTHON_CANOPEN_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

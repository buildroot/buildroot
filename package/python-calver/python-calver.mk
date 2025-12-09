################################################################################
#
# python-calver
#
################################################################################

PYTHON_CALVER_VERSION = 2025.10.20
PYTHON_CALVER_SOURCE = calver-$(PYTHON_CALVER_VERSION).tar.gz
PYTHON_CALVER_SITE = https://files.pythonhosted.org/packages/4a/96/0c57e3e228ffc54074867406b659b197678674f1f0bf600d114965289834
PYTHON_CALVER_SETUP_TYPE = setuptools
PYTHON_CALVER_LICENSE = Apache-2.0
PYTHON_CALVER_LICENSE_FILES = LICENSE

$(eval $(host-python-package))

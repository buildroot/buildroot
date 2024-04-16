################################################################################
#
# python-calver
#
################################################################################

PYTHON_CALVER_VERSION = 2022.6.26
PYTHON_CALVER_SOURCE = calver-$(PYTHON_CALVER_VERSION).tar.gz
PYTHON_CALVER_SITE = https://files.pythonhosted.org/packages/b5/00/96cbed7c019c49ee04b8a08357a981983db7698ae6de402e57097cefc9ad
PYTHON_CALVER_SETUP_TYPE = setuptools
PYTHON_CALVER_LICENSE = Apache-2.0
PYTHON_CALVER_LICENSE_FILES = LICENSE

$(eval $(host-python-package))

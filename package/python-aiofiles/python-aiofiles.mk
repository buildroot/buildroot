################################################################################
#
# python-aiofiles
#
################################################################################

PYTHON_AIOFILES_VERSION = 23.1.0
PYTHON_AIOFILES_SOURCE = aiofiles-$(PYTHON_AIOFILES_VERSION).tar.gz
PYTHON_AIOFILES_SITE = https://files.pythonhosted.org/packages/40/a0/07be94aecba162ed5147359f9883e82afd2ac13aed33678a008fc8c36f8b
PYTHON_AIOFILES_SETUP_TYPE = setuptools
PYTHON_AIOFILES_LICENSE = Apache-2.0
PYTHON_AIOFILES_LICENSE_FILES = LICENSE

$(eval $(python-package))

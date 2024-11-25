################################################################################
#
# python-pefile
#
################################################################################

PYTHON_PEFILE_VERSION = 2024.8.26
PYTHON_PEFILE_SOURCE = pefile-$(PYTHON_PEFILE_VERSION).tar.gz
PYTHON_PEFILE_SITE = https://files.pythonhosted.org/packages/03/4f/2750f7f6f025a1507cd3b7218691671eecfd0bbebebe8b39aa0fe1d360b8
PYTHON_PEFILE_SETUP_TYPE = setuptools
PYTHON_PEFILE_LICENSE = MIT
PYTHON_PEFILE_LICENSE_FILES = LICENSE

$(eval $(host-python-package))

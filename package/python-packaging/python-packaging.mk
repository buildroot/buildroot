################################################################################
#
# python-packaging
#
################################################################################

PYTHON_PACKAGING_VERSION = 20.9
PYTHON_PACKAGING_SOURCE = packaging-$(PYTHON_PACKAGING_VERSION).tar.gz
PYTHON_PACKAGING_SITE = https://files.pythonhosted.org/packages/86/3c/bcd09ec5df7123abcf695009221a52f90438d877a2f1499453c6938f5728
PYTHON_PACKAGING_SETUP_TYPE = setuptools
PYTHON_PACKAGING_LICENSE = Apache-2.0 or BSD-2-Clause
PYTHON_PACKAGING_LICENSE_FILES = LICENSE LICENSE.APACHE LICENSE.BSD

$(eval $(python-package))

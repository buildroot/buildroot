################################################################################
#
# python-xlrd
#
################################################################################

PYTHON_XLRD_VERSION = 2.0.2
PYTHON_XLRD_SOURCE = xlrd-$(PYTHON_XLRD_VERSION).tar.gz
PYTHON_XLRD_SITE = https://files.pythonhosted.org/packages/07/5a/377161c2d3538d1990d7af382c79f3b2372e880b65de21b01b1a2b78691e
PYTHON_XLRD_SETUP_TYPE = setuptools
PYTHON_XLRD_LICENSE = BSD-3-Clause
PYTHON_XLRD_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))

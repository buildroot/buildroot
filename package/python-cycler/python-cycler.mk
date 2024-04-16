################################################################################
#
# python-cycler
#
################################################################################

PYTHON_CYCLER_VERSION = 0.12.1
PYTHON_CYCLER_SOURCE = cycler-$(PYTHON_CYCLER_VERSION).tar.gz
PYTHON_CYCLER_SITE = https://files.pythonhosted.org/packages/a9/95/a3dbbb5028f35eafb79008e7522a75244477d2838f38cbb722248dabc2a8
PYTHON_CYCLER_LICENSE = BSD-3-Clause
PYTHON_CYCLER_LICENSE_FILES = LICENSE
PYTHON_CYCLER_SETUP_TYPE = setuptools

$(eval $(python-package))

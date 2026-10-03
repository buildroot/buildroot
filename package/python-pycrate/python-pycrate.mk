################################################################################
#
# python-pycrate
#
################################################################################

PYTHON_PYCRATE_VERSION = 0.8.1
PYTHON_PYCRATE_SOURCE = pycrate-$(PYTHON_PYCRATE_VERSION).tar.gz
PYTHON_PYCRATE_SITE = https://files.pythonhosted.org/packages/5a/c0/5645340d67be6dce6270418986699f14e24d563865077975b0c2262ebc1a
PYTHON_PYCRATE_SETUP_TYPE = setuptools
PYTHON_PYCRATE_LICENSE = LGPL-2.1+
PYTHON_PYCRATE_LICENSE_FILES = license.txt

$(eval $(python-package))

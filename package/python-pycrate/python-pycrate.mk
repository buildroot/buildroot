################################################################################
#
# python-pycrate
#
################################################################################

PYTHON_PYCRATE_VERSION = 0.7.8
PYTHON_PYCRATE_SOURCE = pycrate-$(PYTHON_PYCRATE_VERSION).tar.gz
PYTHON_PYCRATE_SITE = https://files.pythonhosted.org/packages/01/cb/091d5632190beb38099d095eb35245fe32352375d791d9c3c2403447f79a
PYTHON_PYCRATE_SETUP_TYPE = setuptools
PYTHON_PYCRATE_LICENSE = LGPL-2.1+
PYTHON_PYCRATE_LICENSE_FILES = license.txt

$(eval $(python-package))

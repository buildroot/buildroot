################################################################################
#
# python-pycrate
#
################################################################################

PYTHON_PYCRATE_VERSION = 0.7.2
PYTHON_PYCRATE_SOURCE = pycrate-$(PYTHON_PYCRATE_VERSION).tar.gz
PYTHON_PYCRATE_SITE = https://files.pythonhosted.org/packages/f4/01/09aac6ea758ca7b7b1b4832c0c39003752ef7b6c1478e6db2f34171db3fe
PYTHON_PYCRATE_SETUP_TYPE = setuptools
PYTHON_PYCRATE_LICENSE = LGPL-2.1+
PYTHON_PYCRATE_LICENSE_FILES = license.txt

$(eval $(python-package))

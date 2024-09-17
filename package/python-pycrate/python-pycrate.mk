################################################################################
#
# python-pycrate
#
################################################################################

PYTHON_PYCRATE_VERSION = 0.7.7
PYTHON_PYCRATE_SOURCE = pycrate-$(PYTHON_PYCRATE_VERSION).tar.gz
PYTHON_PYCRATE_SITE = https://files.pythonhosted.org/packages/45/26/04cc9fd3df1a03a5f046e72d35f268c4dfebd278fcad228e81701576ca9d
PYTHON_PYCRATE_SETUP_TYPE = setuptools
PYTHON_PYCRATE_LICENSE = LGPL-2.1+
PYTHON_PYCRATE_LICENSE_FILES = license.txt

$(eval $(python-package))

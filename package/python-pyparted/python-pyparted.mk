################################################################################
#
# python-pyparted
#
################################################################################

PYTHON_PYPARTED_VERSION = 3.12.0
PYTHON_PYPARTED_SOURCE = pyparted-$(PYTHON_PYPARTED_VERSION).tar.gz
PYTHON_PYPARTED_SITE = https://files.pythonhosted.org/packages/c2/d0/d32aa5758d6567eef620075f5c84f475c93bb1bf8da9d17051ce3ef055db
PYTHON_PYPARTED_SETUP_TYPE = setuptools
PYTHON_PYPARTED_LICENSE = GPL-2.0+
PYTHON_PYPARTED_LICENSE_FILES = COPYING
PYTHON_PYPARTED_DEPENDENCIES = parted

$(eval $(python-package))

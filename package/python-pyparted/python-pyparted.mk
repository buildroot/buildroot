################################################################################
#
# python-pyparted
#
################################################################################

PYTHON_PYPARTED_VERSION = 3.13.0
PYTHON_PYPARTED_SOURCE = pyparted-$(PYTHON_PYPARTED_VERSION).tar.gz
PYTHON_PYPARTED_SITE = https://files.pythonhosted.org/packages/e7/53/b02306f89dc3eaf949659e8814545cde575867bc0175f60361809af7f71a
PYTHON_PYPARTED_SETUP_TYPE = setuptools
PYTHON_PYPARTED_LICENSE = GPL-2.0+
PYTHON_PYPARTED_LICENSE_FILES = LICENSE
PYTHON_PYPARTED_DEPENDENCIES = parted

$(eval $(python-package))

################################################################################
#
# python-pylru
#
################################################################################

PYTHON_PYLRU_VERSION = 1.2.1
PYTHON_PYLRU_SOURCE = pylru-$(PYTHON_PYLRU_VERSION).tar.gz
PYTHON_PYLRU_SITE = https://files.pythonhosted.org/packages/95/8e/2a0d3426738db0b41d69d36243bdd00420ad231e802d09dad8db02005d13
PYTHON_PYLRU_SETUP_TYPE = setuptools
PYTHON_PYLRU_LICENSE = GPL-2.0
PYTHON_PYLRU_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

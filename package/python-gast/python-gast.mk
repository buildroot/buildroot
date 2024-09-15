################################################################################
#
# python-gast
#
################################################################################

PYTHON_GAST_VERSION = 0.6.0
PYTHON_GAST_SOURCE = gast-$(PYTHON_GAST_VERSION).tar.gz
PYTHON_GAST_SITE = https://files.pythonhosted.org/packages/3c/14/c566f5ca00c115db7725263408ff952b8ae6d6a4e792ef9c84e77d9af7a1
PYTHON_GAST_SETUP_TYPE = setuptools
PYTHON_GAST_LICENSE = BSD-3-Clause
PYTHON_GAST_LICENSE_FILES = LICENSE

$(eval $(host-python-package))

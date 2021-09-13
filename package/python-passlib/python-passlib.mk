################################################################################
#
# python-passlib
#
################################################################################

PYTHON_PASSLIB_VERSION = 1.7.4
PYTHON_PASSLIB_SOURCE = passlib-$(PYTHON_PASSLIB_VERSION).tar.gz
PYTHON_PASSLIB_SITE = https://files.pythonhosted.org/packages/b6/06/9da9ee59a67fae7761aab3ccc84fa4f3f33f125b370f1ccdb915bf967c11
PYTHON_PASSLIB_SETUP_TYPE = setuptools
PYTHON_PASSLIB_LICENSE = BSD-3-Clause
PYTHON_PASSLIB_LICENSE_FILES = LICENSE

$(eval $(python-package))

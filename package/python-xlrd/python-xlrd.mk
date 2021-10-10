################################################################################
#
# python-xlrd
#
################################################################################

PYTHON_XLRD_VERSION = 2.0.1
PYTHON_XLRD_SOURCE = xlrd-$(PYTHON_XLRD_VERSION).tar.gz
PYTHON_XLRD_SITE = https://files.pythonhosted.org/packages/a6/b3/19a2540d21dea5f908304375bd43f5ed7a4c28a370dc9122c565423e6b44
PYTHON_XLRD_SETUP_TYPE = setuptools
PYTHON_XLRD_LICENSE = BSD-3-Clause
PYTHON_XLRD_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))

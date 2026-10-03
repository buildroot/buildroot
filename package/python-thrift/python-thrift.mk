################################################################################
#
# python-thrift
#
################################################################################

PYTHON_THRIFT_VERSION = 0.24.0
PYTHON_THRIFT_SOURCE = thrift-$(PYTHON_THRIFT_VERSION).tar.gz
PYTHON_THRIFT_SITE = https://files.pythonhosted.org/packages/5f/bd/8f90501b11206e545da3343ed0e5740fc694be24a5f637d7dd7e4e3af927
PYTHON_THRIFT_SETUP_TYPE = setuptools
PYTHON_THRIFT_LICENSE = Apache-2.0
PYTHON_THRIFT_LICENSE_FILES = README.md

$(eval $(python-package))

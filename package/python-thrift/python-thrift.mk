################################################################################
#
# python-thrift
#
################################################################################

PYTHON_THRIFT_VERSION = 0.21.0
PYTHON_THRIFT_SOURCE = thrift-$(PYTHON_THRIFT_VERSION).tar.gz
PYTHON_THRIFT_SITE = https://files.pythonhosted.org/packages/33/1c/418058b4750176b638ab60b4d5a554a2969dcd2363ae458519d0f747adff
PYTHON_THRIFT_SETUP_TYPE = setuptools
PYTHON_THRIFT_LICENSE = Apache-2.0
PYTHON_THRIFT_LICENSE_FILES = README.md

$(eval $(python-package))

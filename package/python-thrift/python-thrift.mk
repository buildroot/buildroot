################################################################################
#
# python-thrift
#
################################################################################

PYTHON_THRIFT_VERSION = 0.22.0
PYTHON_THRIFT_SOURCE = thrift-$(PYTHON_THRIFT_VERSION).tar.gz
PYTHON_THRIFT_SITE = https://files.pythonhosted.org/packages/b2/c2/db648cc10dd7d15560f2eafd92a27cd280811924696e0b4a87175fb28c94
PYTHON_THRIFT_SETUP_TYPE = setuptools
PYTHON_THRIFT_LICENSE = Apache-2.0
PYTHON_THRIFT_LICENSE_FILES = README.md

$(eval $(python-package))

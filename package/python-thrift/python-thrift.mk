################################################################################
#
# python-thrift
#
################################################################################

PYTHON_THRIFT_VERSION = 0.25.0
PYTHON_THRIFT_SOURCE = thrift-$(PYTHON_THRIFT_VERSION).tar.gz
PYTHON_THRIFT_SITE = https://files.pythonhosted.org/packages/65/be/b3f5ef7af6c1209085f45d7004e148de1d157ac5a142a672021b44ef7195
PYTHON_THRIFT_SETUP_TYPE = setuptools
PYTHON_THRIFT_LICENSE = Apache-2.0
PYTHON_THRIFT_LICENSE_FILES = README.md

$(eval $(python-package))

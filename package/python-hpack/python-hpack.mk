################################################################################
#
# python-hpack
#
################################################################################

PYTHON_HPACK_VERSION = 4.1.0
PYTHON_HPACK_SOURCE = hpack-$(PYTHON_HPACK_VERSION).tar.gz
PYTHON_HPACK_SITE = https://files.pythonhosted.org/packages/2c/48/71de9ed269fdae9c8057e5a4c0aa7402e8bb16f2c6e90b3aa53327b113f8
PYTHON_HPACK_SETUP_TYPE = setuptools
PYTHON_HPACK_LICENSE = MIT
PYTHON_HPACK_LICENSE_FILES = LICENSE
PYTHON_HPACK_CPE_ID_VENDOR = python
PYTHON_HPACK_CPE_ID_PRODUCT = hpack

$(eval $(python-package))

################################################################################
#
# python-hpack
#
################################################################################

PYTHON_HPACK_VERSION = 4.2.0
PYTHON_HPACK_SOURCE = hpack-$(PYTHON_HPACK_VERSION).tar.gz
PYTHON_HPACK_SITE = https://files.pythonhosted.org/packages/26/5b/fcabf6028144a8723726318b07a32c2f3314acdff6265743cf08a344b18e
PYTHON_HPACK_SETUP_TYPE = setuptools
PYTHON_HPACK_LICENSE = MIT
PYTHON_HPACK_LICENSE_FILES = LICENSE
PYTHON_HPACK_CPE_ID_VENDOR = python
PYTHON_HPACK_CPE_ID_PRODUCT = hpack

$(eval $(python-package))

################################################################################
#
# python-librt
#
################################################################################

PYTHON_LIBRT_VERSION = 0.7.7
PYTHON_LIBRT_SOURCE = librt-$(PYTHON_LIBRT_VERSION).tar.gz
PYTHON_LIBRT_SITE = https://files.pythonhosted.org/packages/b7/29/47f29026ca17f35cf299290292d5f8331f5077364974b7675a353179afa2
PYTHON_LIBRT_SETUP_TYPE = setuptools
PYTHON_LIBRT_LICENSE = MIT
PYTHON_LIBRT_LICENSE_FILES = LICENSE
PYTHON_LIBRT_ENV = MYPYC_NO_EXTRA_FLAGS=1

$(eval $(python-package))
$(eval $(host-python-package))

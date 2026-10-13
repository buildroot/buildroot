################################################################################
#
# python-librt
#
################################################################################

PYTHON_LIBRT_VERSION = 0.16.0
PYTHON_LIBRT_SOURCE = librt-$(PYTHON_LIBRT_VERSION).tar.gz
PYTHON_LIBRT_SITE = https://files.pythonhosted.org/packages/04/f5/9dc696772d241814bacac7880bac32f2930b5a6ebc1f85317b83161a011c
PYTHON_LIBRT_SETUP_TYPE = setuptools
PYTHON_LIBRT_LICENSE = MIT
PYTHON_LIBRT_LICENSE_FILES = LICENSE
PYTHON_LIBRT_ENV = MYPYC_NO_EXTRA_FLAGS=1
HOST_PYTHON_LIBRT_DEPENDENCIES = host-python-mypy-extensions

$(eval $(python-package))
$(eval $(host-python-package))

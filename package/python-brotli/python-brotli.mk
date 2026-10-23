################################################################################
#
# python-brotli
#
################################################################################

PYTHON_BROTLI_VERSION = 1.2.1
PYTHON_BROTLI_SOURCE = brotli-$(PYTHON_BROTLI_VERSION).tar.gz
PYTHON_BROTLI_SITE = https://files.pythonhosted.org/packages/cf/81/1546c983678a9b4e77cb4718eaedd1b2caf24a6cdbf1eb8775938d22aff7
PYTHON_BROTLI_SETUP_TYPE = setuptools
PYTHON_BROTLI_LICENSE = MIT
PYTHON_BROTLI_LICENSE_FILES = LICENSE
PYTHON_BROTLI_DEPENDENCIES = host-python-pkgconfig

PYTHON_BROTLI_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_68485),y)
PYTHON_BROTLI_CFLAGS += -O0
endif

PYTHON_BROTLI_ENV = CFLAGS="$(PYTHON_BROTLI_CFLAGS)"

$(eval $(python-package))

################################################################################
#
# python-brotli
#
################################################################################

PYTHON_BROTLI_VERSION = 1.2.0
PYTHON_BROTLI_SOURCE = brotli-$(PYTHON_BROTLI_VERSION).tar.gz
PYTHON_BROTLI_SITE = https://files.pythonhosted.org/packages/f7/16/c92ca344d646e71a43b8bb353f0a6490d7f6e06210f8554c8f874e454285
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

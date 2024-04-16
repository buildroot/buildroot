################################################################################
#
# python-brotli
#
################################################################################

PYTHON_BROTLI_VERSION = 1.1.0
PYTHON_BROTLI_SOURCE = Brotli-$(PYTHON_BROTLI_VERSION).tar.gz
PYTHON_BROTLI_SITE = https://files.pythonhosted.org/packages/2f/c2/f9e977608bdf958650638c3f1e28f85a1b075f075ebbe77db8555463787b
PYTHON_BROTLI_SETUP_TYPE = setuptools
PYTHON_BROTLI_LICENSE = MIT
PYTHON_BROTLI_LICENSE_FILES = LICENSE

PYTHON_BROTLI_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_68485),y)
PYTHON_BROTLI_CFLAGS += -O0
endif

PYTHON_BROTLI_ENV = CFLAGS="$(PYTHON_BROTLI_CFLAGS)"

$(eval $(python-package))

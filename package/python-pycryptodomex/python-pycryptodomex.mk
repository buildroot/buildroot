################################################################################
#
# python-pycryptodomex
#
################################################################################

PYTHON_PYCRYPTODOMEX_VERSION = 3.23.0
PYTHON_PYCRYPTODOMEX_SOURCE = pycryptodomex-$(PYTHON_PYCRYPTODOMEX_VERSION).tar.gz
PYTHON_PYCRYPTODOMEX_SITE = https://files.pythonhosted.org/packages/c9/85/e24bf90972a30b0fcd16c73009add1d7d7cd9140c2498a68252028899e41
PYTHON_PYCRYPTODOMEX_SETUP_TYPE = setuptools
PYTHON_PYCRYPTODOMEX_LICENSE = \
	BSD-2-Clause, \
	Public Domain (pycrypto original code)
PYTHON_PYCRYPTODOMEX_LICENSE_FILES = LICENSE.rst Doc/LEGAL/COPYRIGHT.pycrypto
PYTHON_PYCRYPTODOMEX_CPE_ID_VENDOR = pycryptodome
PYTHON_PYCRYPTODOMEX_CPE_ID_PRODUCT = pycryptodomex

PYTHON_PYCRYPTODOMEX_ENV = CFLAGS="$(TARGET_CFLAGS) -std=c99"
HOST_PYTHON_PYCRYPTODOMEX_ENV = CFLAGS="$(HOST_CFLAGS) -std=c99"

$(eval $(python-package))
$(eval $(host-python-package))

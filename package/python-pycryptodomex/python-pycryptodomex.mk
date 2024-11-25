################################################################################
#
# python-pycryptodomex
#
################################################################################

PYTHON_PYCRYPTODOMEX_VERSION = 3.21.0
PYTHON_PYCRYPTODOMEX_SOURCE = pycryptodomex-$(PYTHON_PYCRYPTODOMEX_VERSION).tar.gz
PYTHON_PYCRYPTODOMEX_SITE = https://files.pythonhosted.org/packages/11/dc/e66551683ade663b5f07d7b3bc46434bf703491dbd22ee12d1f979ca828f
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

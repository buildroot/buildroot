################################################################################
#
# python3-pycryptodomex
#
################################################################################

# Please keep in sync with package/python-pycryptodomex/python-pycryptodomex.mk
PYTHON3_PYCRYPTODOMEX_VERSION = 3.11.0
PYTHON3_PYCRYPTODOMEX_SOURCE = pycryptodomex-$(PYTHON3_PYCRYPTODOMEX_VERSION).tar.gz
PYTHON3_PYCRYPTODOMEX_SITE = https://files.pythonhosted.org/packages/47/14/dd9ad29cd29ea4cc521286f2cb401ca7ac6fd5db0791c5e9bacaf2c9ac78
PYTHON3_PYCRYPTODOMEX_SETUP_TYPE = setuptools
PYTHON3_PYCRYPTODOMEX_LICENSE = \
	BSD-2-Clause, \
	Public Domain (pycrypto original code), \
	OCB patent license (OCB mode)
PYTHON3_PYCRYPTODOMEX_LICENSE_FILES = LICENSE.rst Doc/LEGAL/COPYRIGHT.pycrypto
HOST_PYTHON3_PYCRYPTODOMEX_DL_SUBDIR = python-pycryptodomex
HOST_PYTHON3_PYCRYPTODOMEX_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))

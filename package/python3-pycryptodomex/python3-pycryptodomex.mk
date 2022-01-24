################################################################################
#
# python3-pycryptodomex
#
################################################################################

# Please keep in sync with package/python-pycryptodomex/python-pycryptodomex.mk
PYTHON3_PYCRYPTODOMEX_VERSION = 3.13.0
PYTHON3_PYCRYPTODOMEX_SOURCE = pycryptodomex-$(PYTHON3_PYCRYPTODOMEX_VERSION).tar.gz
PYTHON3_PYCRYPTODOMEX_SITE = https://files.pythonhosted.org/packages/7a/21/f399ba8dfd6e40eee444151af3237af22788b8b16077c75ec0419125f619
PYTHON3_PYCRYPTODOMEX_SETUP_TYPE = setuptools
PYTHON3_PYCRYPTODOMEX_LICENSE = \
	BSD-2-Clause, \
	Public Domain (pycrypto original code)
PYTHON3_PYCRYPTODOMEX_LICENSE_FILES = LICENSE.rst Doc/LEGAL/COPYRIGHT.pycrypto
HOST_PYTHON3_PYCRYPTODOMEX_DL_SUBDIR = python-pycryptodomex
HOST_PYTHON3_PYCRYPTODOMEX_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))

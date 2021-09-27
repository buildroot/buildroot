################################################################################
#
# python3-pycryptodomex
#
################################################################################

# Please keep in sync with package/python-pycryptodomex/python-pycryptodomex.mk
PYTHON3_PYCRYPTODOMEX_VERSION = 3.10.1
PYTHON3_PYCRYPTODOMEX_SOURCE = pycryptodomex-$(PYTHON3_PYCRYPTODOMEX_VERSION).tar.gz
PYTHON3_PYCRYPTODOMEX_SITE = https://files.pythonhosted.org/packages/82/e2/a0f9f5452a59bafaa3420585f22b58a8566c4717a88c139af2276bb5695d
PYTHON3_PYCRYPTODOMEX_SETUP_TYPE = setuptools
PYTHON3_PYCRYPTODOMEX_LICENSE = \
	BSD-2-Clause, \
	Public Domain (pycrypto original code), \
	OCB patent license (OCB mode)
PYTHON3_PYCRYPTODOMEX_LICENSE_FILES = LICENSE.rst Doc/LEGAL/COPYRIGHT.pycrypto
HOST_PYTHON3_PYCRYPTODOMEX_DL_SUBDIR = python-pycryptodomex
HOST_PYTHON3_PYCRYPTODOMEX_NEEDS_HOST_PYTHON = python3

$(eval $(host-python-package))

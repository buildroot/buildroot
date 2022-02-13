################################################################################
#
# python-pycryptodomex
#
################################################################################

PYTHON_PYCRYPTODOMEX_VERSION = 3.14.0
PYTHON_PYCRYPTODOMEX_SOURCE = pycryptodomex-$(PYTHON_PYCRYPTODOMEX_VERSION).tar.gz
PYTHON_PYCRYPTODOMEX_SITE = https://files.pythonhosted.org/packages/a6/b3/a5e59cd3ad65d4dc470a3a63381d0495885cf1ac7659c83c6bc9e9e79df6
PYTHON_PYCRYPTODOMEX_SETUP_TYPE = setuptools
PYTHON_PYCRYPTODOMEX_LICENSE = \
	BSD-2-Clause, \
	Public Domain (pycrypto original code)
PYTHON_PYCRYPTODOMEX_LICENSE_FILES = LICENSE.rst Doc/LEGAL/COPYRIGHT.pycrypto

$(eval $(python-package))
$(eval $(host-python-package))

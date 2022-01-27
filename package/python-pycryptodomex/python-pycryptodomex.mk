################################################################################
#
# python-pycryptodomex
#
################################################################################

# Please keep in sync with package/python3-pycryptodomex/python3-pycryptodomex.mk
PYTHON_PYCRYPTODOMEX_VERSION = 3.13.0
PYTHON_PYCRYPTODOMEX_SOURCE = pycryptodomex-$(PYTHON_PYCRYPTODOMEX_VERSION).tar.gz
PYTHON_PYCRYPTODOMEX_SITE = https://files.pythonhosted.org/packages/7a/21/f399ba8dfd6e40eee444151af3237af22788b8b16077c75ec0419125f619
PYTHON_PYCRYPTODOMEX_SETUP_TYPE = setuptools
PYTHON_PYCRYPTODOMEX_LICENSE = \
	BSD-2-Clause, \
	Public Domain (pycrypto original code)
PYTHON_PYCRYPTODOMEX_LICENSE_FILES = LICENSE.rst Doc/LEGAL/COPYRIGHT.pycrypto

$(eval $(python-package))
$(eval $(host-python-package))

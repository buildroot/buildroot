################################################################################
#
# python-pycryptodomex
#
################################################################################

PYTHON_PYCRYPTODOMEX_VERSION = 3.15.0
PYTHON_PYCRYPTODOMEX_SOURCE = pycryptodomex-$(PYTHON_PYCRYPTODOMEX_VERSION).tar.gz
PYTHON_PYCRYPTODOMEX_SITE = https://files.pythonhosted.org/packages/52/0d/6cc95a83f6961a1ca041798d222240890af79b381e97eda3b9b538dba16f
PYTHON_PYCRYPTODOMEX_SETUP_TYPE = setuptools
PYTHON_PYCRYPTODOMEX_LICENSE = \
	BSD-2-Clause, \
	Public Domain (pycrypto original code)
PYTHON_PYCRYPTODOMEX_LICENSE_FILES = LICENSE.rst Doc/LEGAL/COPYRIGHT.pycrypto

define PYTHON_PYCRYPTODOMEX_DELETE_SELFTEST
	rm -fr $(TARGET_DIR)/usr/lib/python3.9/site-packages/Cryptodome/SelfTest
endef

PYTHON_PYCRYPTODOMEX_POST_INSTALL_TARGET_HOOKS += PYTHON_PYCRYPTODOMEX_DELETE_SELFTEST

$(eval $(python-package))
$(eval $(host-python-package))

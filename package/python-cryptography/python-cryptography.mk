################################################################################
#
# python-cryptography
#
################################################################################

PYTHON_CRYPTOGRAPHY_VERSION = 2.6.1
PYTHON_CRYPTOGRAPHY_SOURCE = cryptography-$(PYTHON_CRYPTOGRAPHY_VERSION).tar.gz
PYTHON_CRYPTOGRAPHY_SITE = https://files.pythonhosted.org/packages/07/ca/bc827c5e55918ad223d59d299fff92f3563476c3b00d0a9157d9c0217449
PYTHON_CRYPTOGRAPHY_SETUP_TYPE = setuptools
PYTHON_CRYPTOGRAPHY_LICENSE = Apache-2.0 or BSD-3-Clause
PYTHON_CRYPTOGRAPHY_LICENSE_FILES = LICENSE LICENSE.APACHE LICENSE.BSD
PYTHON_CRYPTOGRAPHY_DEPENDENCIES = host-python-cffi openssl
PYTHON_CRYPTOGRAPHY_ENV = CFLAGS="$(TARGET_CFLAGS) -pthread"

$(eval $(python-package))

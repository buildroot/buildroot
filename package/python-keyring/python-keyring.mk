################################################################################
#
# python-keyring
#
################################################################################

PYTHON_KEYRING_VERSION = 25.5.0
PYTHON_KEYRING_SOURCE = keyring-$(PYTHON_KEYRING_VERSION).tar.gz
PYTHON_KEYRING_SITE = https://files.pythonhosted.org/packages/f6/24/64447b13df6a0e2797b586dad715766d756c932ce8ace7f67bd384d76ae0
PYTHON_KEYRING_SETUP_TYPE = setuptools
PYTHON_KEYRING_LICENSE = MIT
PYTHON_KEYRING_LICENSE_FILES = LICENSE
PYTHON_KEYRING_CPE_ID_VENDOR = python
PYTHON_KEYRING_CPE_ID_PRODUCT = keyring
PYTHON_KEYRING_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

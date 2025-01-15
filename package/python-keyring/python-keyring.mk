################################################################################
#
# python-keyring
#
################################################################################

PYTHON_KEYRING_VERSION = 25.6.0
PYTHON_KEYRING_SOURCE = keyring-$(PYTHON_KEYRING_VERSION).tar.gz
PYTHON_KEYRING_SITE = https://files.pythonhosted.org/packages/70/09/d904a6e96f76ff214be59e7aa6ef7190008f52a0ab6689760a98de0bf37d
PYTHON_KEYRING_SETUP_TYPE = setuptools
PYTHON_KEYRING_LICENSE = MIT
PYTHON_KEYRING_LICENSE_FILES = LICENSE
PYTHON_KEYRING_CPE_ID_VENDOR = python
PYTHON_KEYRING_CPE_ID_PRODUCT = keyring
PYTHON_KEYRING_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

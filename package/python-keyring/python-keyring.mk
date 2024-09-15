################################################################################
#
# python-keyring
#
################################################################################

PYTHON_KEYRING_VERSION = 25.3.0
PYTHON_KEYRING_SOURCE = keyring-$(PYTHON_KEYRING_VERSION).tar.gz
PYTHON_KEYRING_SITE = https://files.pythonhosted.org/packages/32/30/bfdde7294ba6bb2f519950687471dc6a0996d4f77ab30d75c841fa4994ed
PYTHON_KEYRING_SETUP_TYPE = setuptools
PYTHON_KEYRING_LICENSE = MIT
PYTHON_KEYRING_LICENSE_FILES = LICENSE
PYTHON_KEYRING_CPE_ID_VENDOR = python
PYTHON_KEYRING_CPE_ID_PRODUCT = keyring
PYTHON_KEYRING_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

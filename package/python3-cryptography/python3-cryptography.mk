################################################################################
#
# python3-cryptography
#
################################################################################

# Please keep in sync with package/python-cryptography/python-cryptography.mk
PYTHON3_CRYPTOGRAPHY_VERSION = 3.3.2
PYTHON3_CRYPTOGRAPHY_SOURCE = cryptography-$(PYTHON3_CRYPTOGRAPHY_VERSION).tar.gz
PYTHON3_CRYPTOGRAPHY_SITE = https://files.pythonhosted.org/packages/d4/85/38715448253404186029c575d559879912eb8a1c5d16ad9f25d35f7c4f4c
PYTHON3_CRYPTOGRAPHY_SETUP_TYPE = setuptools
PYTHON3_CRYPTOGRAPHY_LICENSE = Apache-2.0 or BSD-3-Clause
PYTHON3_CRYPTOGRAPHY_LICENSE_FILES = LICENSE LICENSE.APACHE LICENSE.BSD
PYTHON3_CRYPTOGRAPHY_CPE_ID_VENDOR = cryptography_project
PYTHON3_CRYPTOGRAPHY_CPE_ID_PRODUCT = cryptography
HOST_PYTHON3_CRYPTOGRAPHY_DL_SUBDIR = python-cryptography
HOST_PYTHON3_CRYPTOGRAPHY_NEEDS_HOST_PYTHON = python3
HOST_PYTHON3_CRYPTOGRAPHY_DEPENDENCIES = \
	host-openssl \
	host-python3-cffi \
	host-python3-pip \
	host-python3-six

$(eval $(host-python-package))

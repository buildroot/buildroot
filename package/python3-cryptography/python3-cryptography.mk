################################################################################
#
# python3-cryptography
#
################################################################################

# Please keep in sync with package/python-cryptography/python-cryptography.mk
PYTHON3_CRYPTOGRAPHY_VERSION = 3.0
PYTHON3_CRYPTOGRAPHY_SOURCE = cryptography-$(PYTHON3_CRYPTOGRAPHY_VERSION).tar.gz
PYTHON3_CRYPTOGRAPHY_SITE = https://files.pythonhosted.org/packages/bf/ac/552fc8729d90393845cc3a2062facf4a89dcbe206fa78771d60ddaae7554
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

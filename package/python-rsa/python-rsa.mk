################################################################################
#
# python-rsa
#
################################################################################

PYTHON_RSA_VERSION = 4.9.1
PYTHON_RSA_SOURCE = rsa-$(PYTHON_RSA_VERSION).tar.gz
PYTHON_RSA_SITE = https://files.pythonhosted.org/packages/da/8a/22b7beea3ee0d44b1916c0c1cb0ee3af23b700b6da9f04991899d0c555d4
PYTHON_RSA_SETUP_TYPE = poetry
PYTHON_RSA_LICENSE = Apache-2.0
PYTHON_RSA_LICENSE_FILES = LICENSE
PYTHON_RSA_CPE_ID_VALID = YES

$(eval $(python-package))

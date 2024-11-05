################################################################################
#
# python-rsa
#
################################################################################

PYTHON_RSA_VERSION = 4.9
PYTHON_RSA_SOURCE = rsa-$(PYTHON_RSA_VERSION).tar.gz
PYTHON_RSA_SITE = https://files.pythonhosted.org/packages/aa/65/7d973b89c4d2351d7fb232c2e452547ddfa243e93131e7cfa766da627b52
PYTHON_RSA_SETUP_TYPE = poetry
PYTHON_RSA_LICENSE = Apache-2.0
PYTHON_RSA_LICENSE_FILES = LICENSE
PYTHON_RSA_CPE_ID_VALID = YES

$(eval $(python-package))

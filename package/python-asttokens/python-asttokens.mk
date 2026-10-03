################################################################################
#
# python-asttokens
#
################################################################################

PYTHON_ASTTOKENS_VERSION = 3.0.2
PYTHON_ASTTOKENS_SOURCE = asttokens-$(PYTHON_ASTTOKENS_VERSION).tar.gz
PYTHON_ASTTOKENS_SITE = https://files.pythonhosted.org/packages/25/1e/faf0f247f6f881b98fc4d6d07e14085cb89d13665084e6d6ac1dc2c03d0b
PYTHON_ASTTOKENS_SETUP_TYPE = setuptools
PYTHON_ASTTOKENS_LICENSE = Apache-2.0
PYTHON_ASTTOKENS_LICENSE_FILES = LICENSE

PYTHON_ASTTOKENS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

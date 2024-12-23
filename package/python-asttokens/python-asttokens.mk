################################################################################
#
# python-asttokens
#
################################################################################

PYTHON_ASTTOKENS_VERSION = 3.0.0
PYTHON_ASTTOKENS_SOURCE = asttokens-$(PYTHON_ASTTOKENS_VERSION).tar.gz
PYTHON_ASTTOKENS_SITE = https://files.pythonhosted.org/packages/4a/e7/82da0a03e7ba5141f05cce0d302e6eed121ae055e0456ca228bf693984bc
PYTHON_ASTTOKENS_SETUP_TYPE = setuptools
PYTHON_ASTTOKENS_LICENSE = Apache-2.0
PYTHON_ASTTOKENS_LICENSE_FILES = LICENSE

PYTHON_ASTTOKENS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

################################################################################
#
# python-asttokens
#
################################################################################

PYTHON_ASTTOKENS_VERSION = 3.0.1
PYTHON_ASTTOKENS_SOURCE = asttokens-$(PYTHON_ASTTOKENS_VERSION).tar.gz
PYTHON_ASTTOKENS_SITE = https://files.pythonhosted.org/packages/be/a5/8e3f9b6771b0b408517c82d97aed8f2036509bc247d46114925e32fe33f0
PYTHON_ASTTOKENS_SETUP_TYPE = setuptools
PYTHON_ASTTOKENS_LICENSE = Apache-2.0
PYTHON_ASTTOKENS_LICENSE_FILES = LICENSE

PYTHON_ASTTOKENS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

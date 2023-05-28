################################################################################
#
# python-asttokens
#
################################################################################

PYTHON_ASTTOKENS_VERSION = 2.2.1
PYTHON_ASTTOKENS_SOURCE = asttokens-$(PYTHON_ASTTOKENS_VERSION).tar.gz
PYTHON_ASTTOKENS_SITE = https://files.pythonhosted.org/packages/c8/e3/b0b4f32162621126fbdaba636c152c6b6baec486c99f48686e66343d638f
PYTHON_ASTTOKENS_SETUP_TYPE = setuptools
PYTHON_ASTTOKENS_LICENSE = Apache-2.0
PYTHON_ASTTOKENS_LICENSE_FILES = LICENSE

PYTHON_ASTTOKENS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

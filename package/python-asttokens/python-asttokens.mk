################################################################################
#
# python-asttokens
#
################################################################################

PYTHON_ASTTOKENS_VERSION = 2.4.1
PYTHON_ASTTOKENS_SOURCE = asttokens-$(PYTHON_ASTTOKENS_VERSION).tar.gz
PYTHON_ASTTOKENS_SITE = https://files.pythonhosted.org/packages/45/1d/f03bcb60c4a3212e15f99a56085d93093a497718adf828d050b9d675da81
PYTHON_ASTTOKENS_SETUP_TYPE = setuptools
PYTHON_ASTTOKENS_LICENSE = Apache-2.0
PYTHON_ASTTOKENS_LICENSE_FILES = LICENSE

PYTHON_ASTTOKENS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

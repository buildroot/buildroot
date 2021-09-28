################################################################################
#
# python-meld3
#
################################################################################

PYTHON_MELD3_VERSION = 2.0.1
PYTHON_MELD3_SOURCE = meld3-$(PYTHON_MELD3_VERSION).tar.gz
PYTHON_MELD3_SITE = https://files.pythonhosted.org/packages/53/af/5b8b67d04a36980de03505446d35db39c7b2a01b9bac1cb673434769ddb8
PYTHON_MELD3_LICENSE = ZPL-2.1
PYTHON_MELD3_LICENSE_FILES = COPYRIGHT.txt LICENSE.txt
PYTHON_MELD3_SETUP_TYPE = setuptools

$(eval $(python-package))

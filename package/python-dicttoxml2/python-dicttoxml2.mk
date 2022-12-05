################################################################################
#
# python-dicttoxml2
#
################################################################################

PYTHON_DICTTOXML2_VERSION = 2.1.0
PYTHON_DICTTOXML2_SOURCE = dicttoxml2-$(PYTHON_DICTTOXML2_VERSION).tar.gz
PYTHON_DICTTOXML2_SITE = https://files.pythonhosted.org/packages/0b/24/7a6d37b2770843e34685e470fd711955cb0f77c354c73d8ca64b02420bce
PYTHON_DICTTOXML2_SETUP_TYPE = setuptools
PYTHON_DICTTOXML2_LICENSE = GPL-2.0
PYTHON_DICTTOXML2_LICENSE_FILES = LICENCE.txt

$(eval $(python-package))

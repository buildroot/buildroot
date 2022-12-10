################################################################################
#
# python-dicttoxml
#
################################################################################

PYTHON_DICTTOXML_VERSION = 1.7.15
PYTHON_DICTTOXML_SOURCE = dicttoxml-$(PYTHON_DICTTOXML_VERSION).tar.gz
PYTHON_DICTTOXML_SITE = https://files.pythonhosted.org/packages/45/b5/efa170fd88e8b8bc025c59592eade0fb7de6ae02ed3dd63957956adc1396
PYTHON_DICTTOXML_SETUP_TYPE = distutils
PYTHON_DICTTOXML_LICENSE = GPL-2.0
PYTHON_DICTTOXML_LICENSE_FILES = LICENCE.txt

$(eval $(python-package))

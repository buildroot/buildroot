################################################################################
#
# python-dicttoxml
#
################################################################################

PYTHON_DICTTOXML_VERSION = 1.7.16
PYTHON_DICTTOXML_SOURCE = dicttoxml-$(PYTHON_DICTTOXML_VERSION).tar.gz
PYTHON_DICTTOXML_SITE = https://files.pythonhosted.org/packages/ee/c9/3132427f9e64d572688e6a1cbe3d542d1a03f676b81fb600f3d1fd7d2ec5
PYTHON_DICTTOXML_SETUP_TYPE = setuptools
PYTHON_DICTTOXML_LICENSE = GPL-2.0
PYTHON_DICTTOXML_LICENSE_FILES = LICENCE.txt

$(eval $(python-package))

################################################################################
#
# python-simplejson
#
################################################################################

PYTHON_SIMPLEJSON_VERSION = 3.17.6
PYTHON_SIMPLEJSON_SOURCE = simplejson-$(PYTHON_SIMPLEJSON_VERSION).tar.gz
PYTHON_SIMPLEJSON_SITE = https://files.pythonhosted.org/packages/7a/47/c7cc3d4ed15f09917838a2fb4e1759eafb6d2f37ebf7043af984d8b36cf7
PYTHON_SIMPLEJSON_LICENSE = Academic Free License (AFL), MIT
PYTHON_SIMPLEJSON_LICENSE_FILES = LICENSE.txt
PYTHON_SIMPLEJSON_CPE_ID_VENDOR = simplejson_project
PYTHON_SIMPLEJSON_CPE_ID_PRODUCT = simplejson
PYTHON_SIMPLEJSON_SETUP_TYPE = setuptools

$(eval $(python-package))

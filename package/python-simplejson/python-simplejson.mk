################################################################################
#
# python-simplejson
#
################################################################################

PYTHON_SIMPLEJSON_VERSION = 4.1.2
PYTHON_SIMPLEJSON_SOURCE = simplejson-$(PYTHON_SIMPLEJSON_VERSION).tar.gz
PYTHON_SIMPLEJSON_SITE = https://files.pythonhosted.org/packages/f1/e3/1cc7dbf4deebc16e9dc42db37f473b5b612d021eb10e69974be308425171
PYTHON_SIMPLEJSON_LICENSE = Academic Free License (AFL), MIT
PYTHON_SIMPLEJSON_LICENSE_FILES = LICENSE.txt
PYTHON_SIMPLEJSON_CPE_ID_VENDOR = simplejson_project
PYTHON_SIMPLEJSON_CPE_ID_PRODUCT = simplejson
PYTHON_SIMPLEJSON_SETUP_TYPE = setuptools

$(eval $(python-package))

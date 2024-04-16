################################################################################
#
# python-simplejson
#
################################################################################

PYTHON_SIMPLEJSON_VERSION = 3.19.2
PYTHON_SIMPLEJSON_SOURCE = simplejson-$(PYTHON_SIMPLEJSON_VERSION).tar.gz
PYTHON_SIMPLEJSON_SITE = https://files.pythonhosted.org/packages/79/79/3ccb95bb4154952532f280f7a41979fbfb0fbbaee4d609810ecb01650afa
PYTHON_SIMPLEJSON_LICENSE = Academic Free License (AFL), MIT
PYTHON_SIMPLEJSON_LICENSE_FILES = LICENSE.txt
PYTHON_SIMPLEJSON_CPE_ID_VENDOR = simplejson_project
PYTHON_SIMPLEJSON_CPE_ID_PRODUCT = simplejson
PYTHON_SIMPLEJSON_SETUP_TYPE = setuptools

$(eval $(python-package))

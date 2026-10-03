################################################################################
#
# python-simplejson
#
################################################################################

PYTHON_SIMPLEJSON_VERSION = 4.2.0
PYTHON_SIMPLEJSON_SOURCE = simplejson-$(PYTHON_SIMPLEJSON_VERSION).tar.gz
PYTHON_SIMPLEJSON_SITE = https://files.pythonhosted.org/packages/2f/f0/ea064bba6c9afda0168ddb834f1c75a93351031e25aee35c046108e7f292
PYTHON_SIMPLEJSON_LICENSE = Academic Free License (AFL), MIT
PYTHON_SIMPLEJSON_LICENSE_FILES = LICENSE.txt
PYTHON_SIMPLEJSON_CPE_ID_VENDOR = simplejson_project
PYTHON_SIMPLEJSON_CPE_ID_PRODUCT = simplejson
PYTHON_SIMPLEJSON_SETUP_TYPE = setuptools

$(eval $(python-package))

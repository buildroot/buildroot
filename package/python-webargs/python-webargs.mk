################################################################################
#
# python-webargs
#
################################################################################

PYTHON_WEBARGS_VERSION = 8.6.0
PYTHON_WEBARGS_SOURCE = webargs-$(PYTHON_WEBARGS_VERSION).tar.gz
PYTHON_WEBARGS_SITE = https://files.pythonhosted.org/packages/8c/51/e9ee5d8315864adf65e92f858f826514538e30db542d4782dd94c2418464
PYTHON_WEBARGS_SETUP_TYPE = flit
PYTHON_WEBARGS_LICENSE = MIT
PYTHON_WEBARGS_LICENSE_FILES = LICENSE
PYTHON_WEBARGS_CPE_ID_VENDOR = webargs_project
PYTHON_WEBARGS_CPE_ID_PRODUCT = webargs

$(eval $(python-package))

################################################################################
#
# python-webargs
#
################################################################################

PYTHON_WEBARGS_VERSION = 8.7.1
PYTHON_WEBARGS_SOURCE = webargs-$(PYTHON_WEBARGS_VERSION).tar.gz
PYTHON_WEBARGS_SITE = https://files.pythonhosted.org/packages/37/64/17afc4e6f47eef154a553c6e56adcc9f1ac3003305c7df978d11aa62937e
PYTHON_WEBARGS_SETUP_TYPE = flit
PYTHON_WEBARGS_LICENSE = MIT
PYTHON_WEBARGS_LICENSE_FILES = LICENSE
PYTHON_WEBARGS_CPE_ID_VENDOR = webargs_project
PYTHON_WEBARGS_CPE_ID_PRODUCT = webargs

$(eval $(python-package))

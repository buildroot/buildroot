################################################################################
#
# python-pyjwt
#
################################################################################

PYTHON_PYJWT_VERSION = 2.9.0
PYTHON_PYJWT_SOURCE = pyjwt-$(PYTHON_PYJWT_VERSION).tar.gz
PYTHON_PYJWT_SITE = https://files.pythonhosted.org/packages/fb/68/ce067f09fca4abeca8771fe667d89cc347d1e99da3e093112ac329c6020e
PYTHON_PYJWT_SETUP_TYPE = setuptools
PYTHON_PYJWT_LICENSE = MIT
PYTHON_PYJWT_LICENSE_FILES = LICENSE
PYTHON_PYJWT_CPE_ID_VENDOR = pyjwt_project
PYTHON_PYJWT_CPE_ID_PRODUCT = pyjwt

$(eval $(python-package))

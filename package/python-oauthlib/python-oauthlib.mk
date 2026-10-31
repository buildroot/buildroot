################################################################################
#
# python-oauthlib
#
################################################################################

PYTHON_OAUTHLIB_VERSION = 4.0.1
PYTHON_OAUTHLIB_SOURCE = oauthlib-$(PYTHON_OAUTHLIB_VERSION).tar.gz
PYTHON_OAUTHLIB_SITE = https://files.pythonhosted.org/packages/33/17/2bb072de0b990303c985f26869fd47bb179024a051f47e7f9d208eb92f8e
PYTHON_OAUTHLIB_SETUP_TYPE = setuptools
PYTHON_OAUTHLIB_LICENSE = BSD-3-Clause
PYTHON_OAUTHLIB_LICENSE_FILES = LICENSE
PYTHON_OAUTHLIB_CPE_ID_VENDOR = oauthlib_project
PYTHON_OAUTHLIB_CPE_ID_PRODUCT = oauthlib

$(eval $(python-package))

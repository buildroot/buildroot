################################################################################
#
# python-oauthlib
#
################################################################################

PYTHON_OAUTHLIB_VERSION = 3.2.2
PYTHON_OAUTHLIB_SOURCE = oauthlib-$(PYTHON_OAUTHLIB_VERSION).tar.gz
PYTHON_OAUTHLIB_SITE = https://files.pythonhosted.org/packages/6d/fa/fbf4001037904031639e6bfbfc02badfc7e12f137a8afa254df6c4c8a670
PYTHON_OAUTHLIB_SETUP_TYPE = setuptools
PYTHON_OAUTHLIB_LICENSE = BSD-3-Clause
PYTHON_OAUTHLIB_LICENSE_FILES = LICENSE
PYTHON_OAUTHLIB_CPE_ID_VENDOR = oauthlib_project
PYTHON_OAUTHLIB_CPE_ID_PRODUCT = oauthlib

$(eval $(python-package))

################################################################################
#
# python-oauthlib
#
################################################################################

PYTHON_OAUTHLIB_VERSION = 4.0.0
PYTHON_OAUTHLIB_SOURCE = oauthlib-$(PYTHON_OAUTHLIB_VERSION).tar.gz
PYTHON_OAUTHLIB_SITE = https://files.pythonhosted.org/packages/7a/d8/a1bcc8ba112a627f8ffbdc212a78ce18d3ac07e91a5ca65d27918eee25a1
PYTHON_OAUTHLIB_SETUP_TYPE = setuptools
PYTHON_OAUTHLIB_LICENSE = BSD-3-Clause
PYTHON_OAUTHLIB_LICENSE_FILES = LICENSE
PYTHON_OAUTHLIB_CPE_ID_VENDOR = oauthlib_project
PYTHON_OAUTHLIB_CPE_ID_PRODUCT = oauthlib

$(eval $(python-package))

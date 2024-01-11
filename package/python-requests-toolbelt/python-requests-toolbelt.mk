################################################################################
#
# python-requests-toolbelt
#
################################################################################

PYTHON_REQUESTS_TOOLBELT_VERSION = 1.0.0
PYTHON_REQUESTS_TOOLBELT_SOURCE = requests-toolbelt-$(PYTHON_REQUESTS_TOOLBELT_VERSION).tar.gz
PYTHON_REQUESTS_TOOLBELT_SITE = https://files.pythonhosted.org/packages/f3/61/d7545dafb7ac2230c70d38d31cbfe4cc64f7144dc41f6e4e4b78ecd9f5bb
PYTHON_REQUESTS_TOOLBELT_SETUP_TYPE = setuptools
PYTHON_REQUESTS_TOOLBELT_LICENSE = Apache-2.0
PYTHON_REQUESTS_TOOLBELT_LICENSE_FILES = LICENSE

$(eval $(python-package))

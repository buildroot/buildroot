################################################################################
#
# python-google-auth
#
################################################################################

PYTHON_GOOGLE_AUTH_VERSION = 2.25.2
PYTHON_GOOGLE_AUTH_SOURCE = google-auth-$(PYTHON_GOOGLE_AUTH_VERSION).tar.gz
PYTHON_GOOGLE_AUTH_SITE = https://files.pythonhosted.org/packages/05/77/84608894384e02f3b0b2621b09ecb0b85e57ba368f13eecbbc43cd1b8719
PYTHON_GOOGLE_AUTH_SETUP_TYPE = setuptools
PYTHON_GOOGLE_AUTH_LICENSE = Apache-2.0
PYTHON_GOOGLE_AUTH_LICENSE_FILES = LICENSE

$(eval $(python-package))

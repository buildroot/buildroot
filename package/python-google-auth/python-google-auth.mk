################################################################################
#
# python-google-auth
#
################################################################################

PYTHON_GOOGLE_AUTH_VERSION = 2.26.1
PYTHON_GOOGLE_AUTH_SOURCE = google-auth-$(PYTHON_GOOGLE_AUTH_VERSION).tar.gz
PYTHON_GOOGLE_AUTH_SITE = https://files.pythonhosted.org/packages/bc/c0/b5119831db4888e703b2adaa912709931181678ae3a50ca08d51a3904765
PYTHON_GOOGLE_AUTH_SETUP_TYPE = setuptools
PYTHON_GOOGLE_AUTH_LICENSE = Apache-2.0
PYTHON_GOOGLE_AUTH_LICENSE_FILES = LICENSE

$(eval $(python-package))

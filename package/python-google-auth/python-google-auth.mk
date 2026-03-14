################################################################################
#
# python-google-auth
#
################################################################################

PYTHON_GOOGLE_AUTH_VERSION = 2.49.1
PYTHON_GOOGLE_AUTH_SOURCE = google_auth-$(PYTHON_GOOGLE_AUTH_VERSION).tar.gz
PYTHON_GOOGLE_AUTH_SITE = https://files.pythonhosted.org/packages/ea/80/6a696a07d3d3b0a92488933532f03dbefa4a24ab80fb231395b9a2a1be77
PYTHON_GOOGLE_AUTH_SETUP_TYPE = setuptools
PYTHON_GOOGLE_AUTH_LICENSE = Apache-2.0
PYTHON_GOOGLE_AUTH_LICENSE_FILES = LICENSE

$(eval $(python-package))

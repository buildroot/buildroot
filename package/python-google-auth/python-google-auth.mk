################################################################################
#
# python-google-auth
#
################################################################################

PYTHON_GOOGLE_AUTH_VERSION = 2.59.1
PYTHON_GOOGLE_AUTH_SOURCE = google_auth-$(PYTHON_GOOGLE_AUTH_VERSION).tar.gz
PYTHON_GOOGLE_AUTH_SITE = https://files.pythonhosted.org/packages/81/e3/9f752a968e487fbc10b2c2a1dd561b62489f923972911009577bb88fe7bb
PYTHON_GOOGLE_AUTH_SETUP_TYPE = setuptools
PYTHON_GOOGLE_AUTH_LICENSE = Apache-2.0
PYTHON_GOOGLE_AUTH_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-requests-oauthlib
#
################################################################################

PYTHON_REQUESTS_OAUTHLIB_VERSION = 2.0.0
PYTHON_REQUESTS_OAUTHLIB_SOURCE = requests-oauthlib-$(PYTHON_REQUESTS_OAUTHLIB_VERSION).tar.gz
PYTHON_REQUESTS_OAUTHLIB_SITE = https://files.pythonhosted.org/packages/42/f2/05f29bc3913aea15eb670be136045bf5c5bbf4b99ecb839da9b422bb2c85
PYTHON_REQUESTS_OAUTHLIB_SETUP_TYPE = setuptools
PYTHON_REQUESTS_OAUTHLIB_LICENSE = ISC
PYTHON_REQUESTS_OAUTHLIB_LICENSE_FILES = LICENSE

$(eval $(python-package))

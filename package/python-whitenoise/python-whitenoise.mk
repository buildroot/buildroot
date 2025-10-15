################################################################################
#
# python-whitenoise
#
################################################################################

PYTHON_WHITENOISE_VERSION = 6.11.0
PYTHON_WHITENOISE_SOURCE = whitenoise-$(PYTHON_WHITENOISE_VERSION).tar.gz
PYTHON_WHITENOISE_SITE = https://files.pythonhosted.org/packages/15/95/8c81ec6b6ebcbf8aca2de7603070ccf37dbb873b03f20708e0f7c1664bc6
PYTHON_WHITENOISE_SETUP_TYPE = setuptools
PYTHON_WHITENOISE_LICENSE = MIT
PYTHON_WHITENOISE_LICENSE_FILES = LICENSE

$(eval $(python-package))

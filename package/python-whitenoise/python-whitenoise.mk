################################################################################
#
# python-whitenoise
#
################################################################################

PYTHON_WHITENOISE_VERSION = 6.12.0
PYTHON_WHITENOISE_SOURCE = whitenoise-$(PYTHON_WHITENOISE_VERSION).tar.gz
PYTHON_WHITENOISE_SITE = https://files.pythonhosted.org/packages/cb/2a/55b3f3a4ec326cd077c1c3defeee656b9298372a69229134d930151acd01
PYTHON_WHITENOISE_SETUP_TYPE = setuptools
PYTHON_WHITENOISE_LICENSE = MIT
PYTHON_WHITENOISE_LICENSE_FILES = LICENSE

$(eval $(python-package))

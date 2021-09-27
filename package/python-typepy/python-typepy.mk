################################################################################
#
# python-typepy
#
################################################################################

PYTHON_TYPEPY_VERSION = 1.3.0
PYTHON_TYPEPY_SOURCE = typepy-$(PYTHON_TYPEPY_VERSION).tar.gz
PYTHON_TYPEPY_SITE = https://files.pythonhosted.org/packages/07/7b/fb32933f2a17992af75c0f96e5538a25fecebd439a82dcc31926ba55d336
PYTHON_TYPEPY_SETUP_TYPE = setuptools
PYTHON_TYPEPY_LICENSE = MIT
PYTHON_TYPEPY_LICENSE_FILES = LICENSE

$(eval $(python-package))

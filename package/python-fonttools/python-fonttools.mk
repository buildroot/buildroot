################################################################################
#
# python-fonttools
#
################################################################################

PYTHON_FONTTOOLS_VERSION = 4.53.1
PYTHON_FONTTOOLS_SOURCE = fonttools-$(PYTHON_FONTTOOLS_VERSION).tar.gz
PYTHON_FONTTOOLS_SITE = https://files.pythonhosted.org/packages/c6/cb/cd80a0da995adde8ade6044a8744aee0da5efea01301cadf770f7fbe7dcc
PYTHON_FONTTOOLS_SETUP_TYPE = setuptools
PYTHON_FONTTOOLS_LICENSE = MIT
PYTHON_FONTTOOLS_LICENSE_FILES = LICENSE
PYTHON_FONTTOOLS_DEPENDENCIES = host-python-cython
PYTHON_FONTTOOLS_ENV = FONTTOOLS_WITH_CYTHON=1

$(eval $(python-package))

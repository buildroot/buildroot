################################################################################
#
# python-fonttools
#
################################################################################

PYTHON_FONTTOOLS_VERSION = 4.54.1
PYTHON_FONTTOOLS_SOURCE = fonttools-$(PYTHON_FONTTOOLS_VERSION).tar.gz
PYTHON_FONTTOOLS_SITE = https://files.pythonhosted.org/packages/11/1d/70b58e342e129f9c0ce030029fb4b2b0670084bbbfe1121d008f6a1e361c
PYTHON_FONTTOOLS_SETUP_TYPE = setuptools
PYTHON_FONTTOOLS_LICENSE = MIT
PYTHON_FONTTOOLS_LICENSE_FILES = LICENSE
PYTHON_FONTTOOLS_DEPENDENCIES = host-python-cython
PYTHON_FONTTOOLS_ENV = FONTTOOLS_WITH_CYTHON=1

$(eval $(python-package))

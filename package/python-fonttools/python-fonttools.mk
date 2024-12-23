################################################################################
#
# python-fonttools
#
################################################################################

PYTHON_FONTTOOLS_VERSION = 4.55.3
PYTHON_FONTTOOLS_SOURCE = fonttools-$(PYTHON_FONTTOOLS_VERSION).tar.gz
PYTHON_FONTTOOLS_SITE = https://files.pythonhosted.org/packages/76/61/a300d1574dc381393424047c0396a0e213db212e28361123af9830d71a8d
PYTHON_FONTTOOLS_SETUP_TYPE = setuptools
PYTHON_FONTTOOLS_LICENSE = MIT
PYTHON_FONTTOOLS_LICENSE_FILES = LICENSE
PYTHON_FONTTOOLS_DEPENDENCIES = host-python-cython
PYTHON_FONTTOOLS_ENV = FONTTOOLS_WITH_CYTHON=1

$(eval $(python-package))

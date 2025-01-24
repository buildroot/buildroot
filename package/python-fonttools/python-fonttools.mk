################################################################################
#
# python-fonttools
#
################################################################################

PYTHON_FONTTOOLS_VERSION = 4.55.5
PYTHON_FONTTOOLS_SOURCE = fonttools-$(PYTHON_FONTTOOLS_VERSION).tar.gz
PYTHON_FONTTOOLS_SITE = https://files.pythonhosted.org/packages/8b/d0/6a515b1587f2fe3540429120b20c674687e6f5fdd7dbd114f0fca224294b
PYTHON_FONTTOOLS_SETUP_TYPE = setuptools
PYTHON_FONTTOOLS_LICENSE = MIT
PYTHON_FONTTOOLS_LICENSE_FILES = LICENSE
PYTHON_FONTTOOLS_DEPENDENCIES = host-python-cython
PYTHON_FONTTOOLS_ENV = FONTTOOLS_WITH_CYTHON=1

$(eval $(python-package))

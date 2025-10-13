################################################################################
#
# python-sympy
#
################################################################################

PYTHON_SYMPY_VERSION = 1.14.0
PYTHON_SYMPY_SOURCE = sympy-$(PYTHON_SYMPY_VERSION).tar.gz
PYTHON_SYMPY_SITE = https://files.pythonhosted.org/packages/83/d3/803453b36afefb7c2bb238361cd4ae6125a569b4db67cd9e79846ba2d68c
PYTHON_SYMPY_SETUP_TYPE = setuptools
PYTHON_SYMPY_LICENSE = BSD-3-Clause
PYTHON_SYMPY_LICENSE_FILES = LICENSE data/TeXmacs/LICENSE sympy/parsing/latex/LICENSE.txt

$(eval $(python-package))

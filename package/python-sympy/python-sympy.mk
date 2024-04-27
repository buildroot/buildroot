################################################################################
#
# python-sympy
#
################################################################################

PYTHON_SYMPY_VERSION = 1.12
PYTHON_SYMPY_SOURCE = sympy-$(PYTHON_SYMPY_VERSION).tar.gz
PYTHON_SYMPY_SITE = https://github.com/sympy/sympy/releases/download/sympy-$(PYTHON_SYMPY_VERSION)
PYTHON_SYMPY_SETUP_TYPE = setuptools
PYTHON_SYMPY_LICENSE = BSD-3-Clause
PYTHON_SYMPY_LICENSE_FILES = LICENSE data/TeXmacs/LICENSE sympy/parsing/latex/LICENSE.txt

$(eval $(python-package))

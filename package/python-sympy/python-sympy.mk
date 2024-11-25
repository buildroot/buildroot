################################################################################
#
# python-sympy
#
################################################################################

PYTHON_SYMPY_VERSION = 1.13.3
PYTHON_SYMPY_SOURCE = sympy-$(PYTHON_SYMPY_VERSION).tar.gz
PYTHON_SYMPY_SITE = https://files.pythonhosted.org/packages/11/8a/5a7fd6284fa8caac23a26c9ddf9c30485a48169344b4bd3b0f02fef1890f
PYTHON_SYMPY_SETUP_TYPE = setuptools
PYTHON_SYMPY_LICENSE = BSD-3-Clause
PYTHON_SYMPY_LICENSE_FILES = LICENSE data/TeXmacs/LICENSE sympy/parsing/latex/LICENSE.txt

$(eval $(python-package))

################################################################################
#
# python-xlsxwriter
#
################################################################################

PYTHON_XLSXWRITER_VERSION = 3.2.0
PYTHON_XLSXWRITER_SOURCE = XlsxWriter-$(PYTHON_XLSXWRITER_VERSION).tar.gz
PYTHON_XLSXWRITER_SITE = https://files.pythonhosted.org/packages/a6/c3/b36fa44a0610a0f65d2e65ba6a262cbe2554b819f1449731971f7c16ea3c
PYTHON_XLSXWRITER_SETUP_TYPE = setuptools
PYTHON_XLSXWRITER_LICENSE = BSD-2-Clause
PYTHON_XLSXWRITER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

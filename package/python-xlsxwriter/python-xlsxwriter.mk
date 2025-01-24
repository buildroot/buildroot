################################################################################
#
# python-xlsxwriter
#
################################################################################

PYTHON_XLSXWRITER_VERSION = 3.2.1
PYTHON_XLSXWRITER_SOURCE = XlsxWriter-$(PYTHON_XLSXWRITER_VERSION).tar.gz
PYTHON_XLSXWRITER_SITE = https://files.pythonhosted.org/packages/48/4f/108b0bada5cfcc47c24ea6181f4c563fbafef50bcc0054089c256b2ae578
PYTHON_XLSXWRITER_SETUP_TYPE = setuptools
PYTHON_XLSXWRITER_LICENSE = BSD-2-Clause
PYTHON_XLSXWRITER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

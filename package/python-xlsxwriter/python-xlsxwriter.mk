################################################################################
#
# python-xlsxwriter
#
################################################################################

PYTHON_XLSXWRITER_VERSION = 3.3.0
PYTHON_XLSXWRITER_SOURCE = xlsxwriter-$(PYTHON_XLSXWRITER_VERSION).tar.gz
PYTHON_XLSXWRITER_SITE = https://files.pythonhosted.org/packages/93/f2/98b45e52bc0330256bd4bb039cc44b28f838ad85602ce4f358f355d501bb
PYTHON_XLSXWRITER_SETUP_TYPE = setuptools
PYTHON_XLSXWRITER_LICENSE = BSD-2-Clause
PYTHON_XLSXWRITER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

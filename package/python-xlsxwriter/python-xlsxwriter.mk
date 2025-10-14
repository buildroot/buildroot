################################################################################
#
# python-xlsxwriter
#
################################################################################

PYTHON_XLSXWRITER_VERSION = 3.2.9
PYTHON_XLSXWRITER_SOURCE = xlsxwriter-$(PYTHON_XLSXWRITER_VERSION).tar.gz
PYTHON_XLSXWRITER_SITE = https://files.pythonhosted.org/packages/46/2c/c06ef49dc36e7954e55b802a8b231770d286a9758b3d936bd1e04ce5ba88
PYTHON_XLSXWRITER_SETUP_TYPE = setuptools
PYTHON_XLSXWRITER_LICENSE = BSD-2-Clause
PYTHON_XLSXWRITER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

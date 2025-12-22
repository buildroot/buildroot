################################################################################
#
# python-sqlparse
#
################################################################################

PYTHON_SQLPARSE_VERSION = 0.5.5
PYTHON_SQLPARSE_SOURCE = sqlparse-$(PYTHON_SQLPARSE_VERSION).tar.gz
PYTHON_SQLPARSE_SITE = https://files.pythonhosted.org/packages/90/76/437d71068094df0726366574cf3432a4ed754217b436eb7429415cf2d480
PYTHON_SQLPARSE_SETUP_TYPE = hatch
PYTHON_SQLPARSE_LICENSE = BSD-3-Clause
PYTHON_SQLPARSE_LICENSE_FILES = LICENSE
PYTHON_SQLPARSE_CPE_ID_VENDOR = sqlparse_project
PYTHON_SQLPARSE_CPE_ID_PRODUCT = sqlparse

$(eval $(python-package))

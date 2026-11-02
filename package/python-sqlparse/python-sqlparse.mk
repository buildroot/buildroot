################################################################################
#
# python-sqlparse
#
################################################################################

PYTHON_SQLPARSE_VERSION = 0.6.1
PYTHON_SQLPARSE_SOURCE = sqlparse-$(PYTHON_SQLPARSE_VERSION).tar.gz
PYTHON_SQLPARSE_SITE = https://files.pythonhosted.org/packages/7e/e0/361c764ea58cc1a75f7b4b424a74b08449db8bfa5e9199c7275999fdd1b9
PYTHON_SQLPARSE_SETUP_TYPE = hatch
PYTHON_SQLPARSE_LICENSE = BSD-3-Clause
PYTHON_SQLPARSE_LICENSE_FILES = LICENSE
PYTHON_SQLPARSE_CPE_ID_VENDOR = sqlparse_project
PYTHON_SQLPARSE_CPE_ID_PRODUCT = sqlparse

$(eval $(python-package))

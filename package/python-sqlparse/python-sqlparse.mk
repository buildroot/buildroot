################################################################################
#
# python-sqlparse
#
################################################################################

PYTHON_SQLPARSE_VERSION = 0.4.4
PYTHON_SQLPARSE_SOURCE = sqlparse-$(PYTHON_SQLPARSE_VERSION).tar.gz
PYTHON_SQLPARSE_SITE = https://files.pythonhosted.org/packages/65/16/10f170ec641ed852611b6c9441b23d10b5702ab5288371feab3d36de2574
PYTHON_SQLPARSE_SETUP_TYPE = flit
PYTHON_SQLPARSE_LICENSE = BSD-3-Clause
PYTHON_SQLPARSE_LICENSE_FILES = LICENSE
PYTHON_SQLPARSE_CPE_ID_VENDOR = sqlparse_project
PYTHON_SQLPARSE_CPE_ID_PRODUCT = sqlparse

$(eval $(python-package))

################################################################################
#
# python-sqlparse
#
################################################################################

PYTHON_SQLPARSE_VERSION = 0.6.0
PYTHON_SQLPARSE_SOURCE = sqlparse-$(PYTHON_SQLPARSE_VERSION).tar.gz
PYTHON_SQLPARSE_SITE = https://files.pythonhosted.org/packages/5f/d3/3f06a1006f2261d1342aefb3c71eed02f5d4ca5bdbecd86ebc12ad38306e
PYTHON_SQLPARSE_SETUP_TYPE = hatch
PYTHON_SQLPARSE_LICENSE = BSD-3-Clause
PYTHON_SQLPARSE_LICENSE_FILES = LICENSE
PYTHON_SQLPARSE_CPE_ID_VENDOR = sqlparse_project
PYTHON_SQLPARSE_CPE_ID_PRODUCT = sqlparse

$(eval $(python-package))

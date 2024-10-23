################################################################################
#
# python-sqlparse
#
################################################################################

PYTHON_SQLPARSE_VERSION = 0.5.1
PYTHON_SQLPARSE_SOURCE = sqlparse-$(PYTHON_SQLPARSE_VERSION).tar.gz
PYTHON_SQLPARSE_SITE = https://files.pythonhosted.org/packages/73/82/dfa23ec2cbed08a801deab02fe7c904bfb00765256b155941d789a338c68
PYTHON_SQLPARSE_SETUP_TYPE = hatch
PYTHON_SQLPARSE_LICENSE = BSD-3-Clause
PYTHON_SQLPARSE_LICENSE_FILES = LICENSE
PYTHON_SQLPARSE_CPE_ID_VENDOR = sqlparse_project
PYTHON_SQLPARSE_CPE_ID_PRODUCT = sqlparse

$(eval $(python-package))

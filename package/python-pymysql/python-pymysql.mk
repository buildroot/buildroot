################################################################################
#
# python-pymysql
#
################################################################################

PYTHON_PYMYSQL_VERSION = 1.2.3
PYTHON_PYMYSQL_SOURCE = pymysql-$(PYTHON_PYMYSQL_VERSION).tar.gz
PYTHON_PYMYSQL_SITE = https://files.pythonhosted.org/packages/b1/d4/c15b459e25a23767d2f4065ef40968920320f04e302889574310c21c96a3
PYTHON_PYMYSQL_LICENSE = MIT
PYTHON_PYMYSQL_LICENSE_FILES = LICENSE
PYTHON_PYMYSQL_SETUP_TYPE = setuptools

$(eval $(python-package))

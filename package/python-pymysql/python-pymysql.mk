################################################################################
#
# python-pymysql
#
################################################################################

PYTHON_PYMYSQL_VERSION = 1.1.1
PYTHON_PYMYSQL_SOURCE = pymysql-$(PYTHON_PYMYSQL_VERSION).tar.gz
PYTHON_PYMYSQL_SITE = https://files.pythonhosted.org/packages/b3/8f/ce59b5e5ed4ce8512f879ff1fa5ab699d211ae2495f1adaa5fbba2a1eada
PYTHON_PYMYSQL_LICENSE = MIT
PYTHON_PYMYSQL_LICENSE_FILES = LICENSE
PYTHON_PYMYSQL_SETUP_TYPE = setuptools

$(eval $(python-package))

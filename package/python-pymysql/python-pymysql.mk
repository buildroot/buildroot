################################################################################
#
# python-pymysql
#
################################################################################

PYTHON_PYMYSQL_VERSION = 1.1.0
PYTHON_PYMYSQL_SOURCE = PyMySQL-$(PYTHON_PYMYSQL_VERSION).tar.gz
PYTHON_PYMYSQL_SITE = https://files.pythonhosted.org/packages/41/9d/ee68dee1c8821c839bb31e6e5f40e61035a5278f7c1307dde758f0c90452
PYTHON_PYMYSQL_LICENSE = MIT
PYTHON_PYMYSQL_LICENSE_FILES = LICENSE
PYTHON_PYMYSQL_SETUP_TYPE = setuptools

$(eval $(python-package))

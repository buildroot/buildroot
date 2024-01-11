################################################################################
#
# python-sqliteschema
#
################################################################################

PYTHON_SQLITESCHEMA_VERSION = 2.0.0
PYTHON_SQLITESCHEMA_SOURCE = sqliteschema-$(PYTHON_SQLITESCHEMA_VERSION).tar.gz
PYTHON_SQLITESCHEMA_SITE = https://files.pythonhosted.org/packages/29/e7/4482eebf6d8ff7923bb3fd0e9239d3e634f67125cfda3001c88506b939b9
PYTHON_SQLITESCHEMA_SETUP_TYPE = setuptools
PYTHON_SQLITESCHEMA_LICENSE = MIT
PYTHON_SQLITESCHEMA_LICENSE_FILES = LICENSE

$(eval $(python-package))

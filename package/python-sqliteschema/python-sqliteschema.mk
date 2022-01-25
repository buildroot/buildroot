################################################################################
#
# python-sqliteschema
#
################################################################################

PYTHON_SQLITESCHEMA_VERSION = 1.2.1
PYTHON_SQLITESCHEMA_SOURCE = sqliteschema-$(PYTHON_SQLITESCHEMA_VERSION).tar.gz
PYTHON_SQLITESCHEMA_SITE = https://files.pythonhosted.org/packages/85/f8/be54d4bebf551cb533d1dea11c3bf165a1a408c2a1cceb1f9724aadd9967
PYTHON_SQLITESCHEMA_SETUP_TYPE = setuptools
PYTHON_SQLITESCHEMA_LICENSE = MIT
PYTHON_SQLITESCHEMA_LICENSE_FILES = LICENSE

$(eval $(python-package))

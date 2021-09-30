################################################################################
#
# python-sqliteschema
#
################################################################################

PYTHON_SQLITESCHEMA_VERSION = 1.2.0
PYTHON_SQLITESCHEMA_SOURCE = sqliteschema-$(PYTHON_SQLITESCHEMA_VERSION).tar.gz
PYTHON_SQLITESCHEMA_SITE = https://files.pythonhosted.org/packages/5c/d3/0c2e4c989a8d45f9443e431d7cbf89af4aba719fb0647b5f722716ef3990
PYTHON_SQLITESCHEMA_SETUP_TYPE = setuptools
PYTHON_SQLITESCHEMA_LICENSE = MIT
PYTHON_SQLITESCHEMA_LICENSE_FILES = LICENSE

$(eval $(python-package))

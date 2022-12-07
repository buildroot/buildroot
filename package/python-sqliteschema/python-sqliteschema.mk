################################################################################
#
# python-sqliteschema
#
################################################################################

PYTHON_SQLITESCHEMA_VERSION = 1.3.0
PYTHON_SQLITESCHEMA_SOURCE = sqliteschema-$(PYTHON_SQLITESCHEMA_VERSION).tar.gz
PYTHON_SQLITESCHEMA_SITE = https://files.pythonhosted.org/packages/3d/ff/91cfff0c96f9ba2bddc27d6855db4907af77551a267b86740c8842beeb78
PYTHON_SQLITESCHEMA_SETUP_TYPE = setuptools
PYTHON_SQLITESCHEMA_LICENSE = MIT
PYTHON_SQLITESCHEMA_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-sqliteschema
#
################################################################################

PYTHON_SQLITESCHEMA_VERSION = 2.0.1
PYTHON_SQLITESCHEMA_SOURCE = sqliteschema-$(PYTHON_SQLITESCHEMA_VERSION).tar.gz
PYTHON_SQLITESCHEMA_SITE = https://files.pythonhosted.org/packages/90/ad/0d7010b15899d25ee832b89d0d79b501c4d0c7d0d03c06e84c1cd1383326
PYTHON_SQLITESCHEMA_SETUP_TYPE = setuptools
PYTHON_SQLITESCHEMA_LICENSE = MIT
PYTHON_SQLITESCHEMA_LICENSE_FILES = LICENSE
PYTHON_SQLITESCHEMA_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

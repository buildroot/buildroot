################################################################################
#
# python-sqlalchemy
#
################################################################################

PYTHON_SQLALCHEMY_VERSION = 2.1.6
PYTHON_SQLALCHEMY_SOURCE = sqlalchemy-$(PYTHON_SQLALCHEMY_VERSION).tar.gz
PYTHON_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/36/dc/9addbf490110b5727380059ee542ad8353bdcee45a37ba6a5e0976966ae0
PYTHON_SQLALCHEMY_SETUP_TYPE = setuptools
PYTHON_SQLALCHEMY_LICENSE = MIT
PYTHON_SQLALCHEMY_LICENSE_FILES = LICENSE
PYTHON_SQLALCHEMY_CPE_ID_VENDOR = sqlalchemy
PYTHON_SQLALCHEMY_CPE_ID_PRODUCT = sqlalchemy
PYTHON_SQLALCHEMY_DEPENDENCIES = host-python-cython

$(eval $(python-package))

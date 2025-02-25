################################################################################
#
# python-sqlalchemy
#
################################################################################

PYTHON_SQLALCHEMY_VERSION = 2.0.38
PYTHON_SQLALCHEMY_SOURCE = sqlalchemy-$(PYTHON_SQLALCHEMY_VERSION).tar.gz
PYTHON_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/e4/08/9a90962ea72acd532bda71249a626344d855c4032603924b1b547694b837
PYTHON_SQLALCHEMY_SETUP_TYPE = setuptools
PYTHON_SQLALCHEMY_LICENSE = MIT
PYTHON_SQLALCHEMY_LICENSE_FILES = LICENSE
PYTHON_SQLALCHEMY_CPE_ID_VENDOR = sqlalchemy
PYTHON_SQLALCHEMY_CPE_ID_PRODUCT = sqlalchemy
PYTHON_SQLALCHEMY_DEPENDENCIES = host-python-cython

$(eval $(python-package))

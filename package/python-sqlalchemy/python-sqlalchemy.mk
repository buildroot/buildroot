################################################################################
#
# python-sqlalchemy
#
################################################################################

PYTHON_SQLALCHEMY_VERSION = 2.0.39
PYTHON_SQLALCHEMY_SOURCE = sqlalchemy-$(PYTHON_SQLALCHEMY_VERSION).tar.gz
PYTHON_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/00/8e/e77fcaa67f8b9f504b4764570191e291524575ddbfe78a90fc656d671fdc
PYTHON_SQLALCHEMY_SETUP_TYPE = setuptools
PYTHON_SQLALCHEMY_LICENSE = MIT
PYTHON_SQLALCHEMY_LICENSE_FILES = LICENSE
PYTHON_SQLALCHEMY_CPE_ID_VENDOR = sqlalchemy
PYTHON_SQLALCHEMY_CPE_ID_PRODUCT = sqlalchemy
PYTHON_SQLALCHEMY_DEPENDENCIES = host-python-cython

$(eval $(python-package))

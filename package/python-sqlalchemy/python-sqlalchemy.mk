################################################################################
#
# python-sqlalchemy
#
################################################################################

PYTHON_SQLALCHEMY_VERSION = 2.1.5
PYTHON_SQLALCHEMY_SOURCE = sqlalchemy-$(PYTHON_SQLALCHEMY_VERSION).tar.gz
PYTHON_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/08/bb/28e3106ee586e5b2f5ecf211eec1348055f0f926314b13fe23b9cffa9039
PYTHON_SQLALCHEMY_SETUP_TYPE = setuptools
PYTHON_SQLALCHEMY_LICENSE = MIT
PYTHON_SQLALCHEMY_LICENSE_FILES = LICENSE
PYTHON_SQLALCHEMY_CPE_ID_VENDOR = sqlalchemy
PYTHON_SQLALCHEMY_CPE_ID_PRODUCT = sqlalchemy
PYTHON_SQLALCHEMY_DEPENDENCIES = host-python-cython

$(eval $(python-package))

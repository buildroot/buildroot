################################################################################
#
# python-marshmallow-sqlalchemy
#
################################################################################

PYTHON_MARSHMALLOW_SQLALCHEMY_VERSION = 1.1.0
PYTHON_MARSHMALLOW_SQLALCHEMY_SOURCE = marshmallow_sqlalchemy-$(PYTHON_MARSHMALLOW_SQLALCHEMY_VERSION).tar.gz
PYTHON_MARSHMALLOW_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/82/f8/2e565045b17dd60b38aafc3242ac44f5403315df08963501d07463d089ac
PYTHON_MARSHMALLOW_SQLALCHEMY_SETUP_TYPE = flit
PYTHON_MARSHMALLOW_SQLALCHEMY_LICENSE = MIT
PYTHON_MARSHMALLOW_SQLALCHEMY_LICENSE_FILES = LICENSE

$(eval $(python-package))

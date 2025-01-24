################################################################################
#
# python-marshmallow-sqlalchemy
#
################################################################################

PYTHON_MARSHMALLOW_SQLALCHEMY_VERSION = 1.4.0
PYTHON_MARSHMALLOW_SQLALCHEMY_SOURCE = marshmallow_sqlalchemy-$(PYTHON_MARSHMALLOW_SQLALCHEMY_VERSION).tar.gz
PYTHON_MARSHMALLOW_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/6d/0c/89544d2b3aeae4af61ecd9df347d61d36768a67563e47b98423a853e8470
PYTHON_MARSHMALLOW_SQLALCHEMY_SETUP_TYPE = flit
PYTHON_MARSHMALLOW_SQLALCHEMY_LICENSE = MIT
PYTHON_MARSHMALLOW_SQLALCHEMY_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-marshmallow-sqlalchemy
#
################################################################################

PYTHON_MARSHMALLOW_SQLALCHEMY_VERSION = 0.28.1
PYTHON_MARSHMALLOW_SQLALCHEMY_SOURCE = marshmallow-sqlalchemy-$(PYTHON_MARSHMALLOW_SQLALCHEMY_VERSION).tar.gz
PYTHON_MARSHMALLOW_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/eb/96/3895bde2247fa653c36d887ff08e439665668aa7c991a3924ae199be88d6
PYTHON_MARSHMALLOW_SQLALCHEMY_SETUP_TYPE = setuptools
PYTHON_MARSHMALLOW_SQLALCHEMY_LICENSE = MIT
PYTHON_MARSHMALLOW_SQLALCHEMY_LICENSE_FILES = LICENSE

$(eval $(python-package))

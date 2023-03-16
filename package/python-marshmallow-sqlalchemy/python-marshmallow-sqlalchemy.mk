################################################################################
#
# python-marshmallow-sqlalchemy
#
################################################################################

PYTHON_MARSHMALLOW_SQLALCHEMY_VERSION = 0.29.0
PYTHON_MARSHMALLOW_SQLALCHEMY_SOURCE = marshmallow-sqlalchemy-$(PYTHON_MARSHMALLOW_SQLALCHEMY_VERSION).tar.gz
PYTHON_MARSHMALLOW_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/fa/0d/4dd275732213cefb4e49a86c60443cb1e3e0d0bd605625aed3fa7bb22fdd
PYTHON_MARSHMALLOW_SQLALCHEMY_SETUP_TYPE = setuptools
PYTHON_MARSHMALLOW_SQLALCHEMY_LICENSE = MIT
PYTHON_MARSHMALLOW_SQLALCHEMY_LICENSE_FILES = LICENSE

$(eval $(python-package))

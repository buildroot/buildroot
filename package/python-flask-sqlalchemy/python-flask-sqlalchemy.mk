################################################################################
#
# python-flask-sqlalchemy
#
################################################################################

PYTHON_FLASK_SQLALCHEMY_VERSION = 3.1.1
PYTHON_FLASK_SQLALCHEMY_SOURCE = flask_sqlalchemy-$(PYTHON_FLASK_SQLALCHEMY_VERSION).tar.gz
PYTHON_FLASK_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/91/53/b0a9fcc1b1297f51e68b69ed3b7c3c40d8c45be1391d77ae198712914392
PYTHON_FLASK_SQLALCHEMY_SETUP_TYPE = setuptools
PYTHON_FLASK_SQLALCHEMY_LICENSE = BSD-3-Clause
PYTHON_FLASK_SQLALCHEMY_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

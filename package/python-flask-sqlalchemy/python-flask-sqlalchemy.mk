################################################################################
#
# python-flask-sqlalchemy
#
################################################################################

PYTHON_FLASK_SQLALCHEMY_VERSION = 2.5.1
PYTHON_FLASK_SQLALCHEMY_SOURCE = Flask-SQLAlchemy-$(PYTHON_FLASK_SQLALCHEMY_VERSION).tar.gz
PYTHON_FLASK_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/35/f0/39dd2d8e7e5223f78a5206d7020dc0e16718a964acfb3564d89e9798ab9b
PYTHON_FLASK_SQLALCHEMY_SETUP_TYPE = setuptools
PYTHON_FLASK_SQLALCHEMY_LICENSE = BSD-3-Clause
PYTHON_FLASK_SQLALCHEMY_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

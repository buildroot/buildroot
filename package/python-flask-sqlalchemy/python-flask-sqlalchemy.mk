################################################################################
#
# python-flask-sqlalchemy
#
################################################################################

PYTHON_FLASK_SQLALCHEMY_VERSION = 3.0.2
PYTHON_FLASK_SQLALCHEMY_SOURCE = Flask-SQLAlchemy-$(PYTHON_FLASK_SQLALCHEMY_VERSION).tar.gz
PYTHON_FLASK_SQLALCHEMY_SITE = https://files.pythonhosted.org/packages/0b/b7/05a8f9c3f010775275f8dec53e40ff7ea1ae61bf1cfa4b524caf4d3da982
PYTHON_FLASK_SQLALCHEMY_SETUP_TYPE = setuptools
PYTHON_FLASK_SQLALCHEMY_LICENSE = BSD-3-Clause
PYTHON_FLASK_SQLALCHEMY_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

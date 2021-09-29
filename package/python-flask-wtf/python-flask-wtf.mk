################################################################################
#
# python-flask-wtf
#
################################################################################

PYTHON_FLASK_WTF_VERSION = 0.14.3
PYTHON_FLASK_WTF_SOURCE = Flask-WTF-$(PYTHON_FLASK_WTF_VERSION).tar.gz
PYTHON_FLASK_WTF_SITE = https://files.pythonhosted.org/packages/2e/f4/3d9e1905ffad67e20ef4f5963d711e8e29ab9439120d7ffec3d2922020e3
PYTHON_FLASK_WTF_LICENSE = BSD-3-Clause
PYTHON_FLASK_WTF_LICENSE_FILES = LICENSE
PYTHON_FLASK_WTF_SETUP_TYPE = setuptools

$(eval $(python-package))

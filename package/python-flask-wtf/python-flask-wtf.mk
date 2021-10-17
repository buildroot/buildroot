################################################################################
#
# python-flask-wtf
#
################################################################################

PYTHON_FLASK_WTF_VERSION = 0.15.1
PYTHON_FLASK_WTF_SOURCE = Flask-WTF-$(PYTHON_FLASK_WTF_VERSION).tar.gz
PYTHON_FLASK_WTF_SITE = https://files.pythonhosted.org/packages/9c/b5/4b48cece7b31aac2beab115330c2978ef4deee3aeb0dd1037c9b7a71b8c3
PYTHON_FLASK_WTF_LICENSE = BSD-3-Clause
PYTHON_FLASK_WTF_LICENSE_FILES = LICENSE
PYTHON_FLASK_WTF_SETUP_TYPE = setuptools

$(eval $(python-package))

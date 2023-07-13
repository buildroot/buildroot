################################################################################
#
# python-flask-wtf
#
################################################################################

PYTHON_FLASK_WTF_VERSION = 1.1.1
PYTHON_FLASK_WTF_SOURCE = Flask-WTF-$(PYTHON_FLASK_WTF_VERSION).tar.gz
PYTHON_FLASK_WTF_SITE = https://files.pythonhosted.org/packages/80/55/5114035eb8f6200fbe838a4b9828409ac831408c4591bf7875aed299d5f8
PYTHON_FLASK_WTF_LICENSE = BSD-3-Clause
PYTHON_FLASK_WTF_LICENSE_FILES = LICENSE.rst
PYTHON_FLASK_WTF_SETUP_TYPE = setuptools

$(eval $(python-package))

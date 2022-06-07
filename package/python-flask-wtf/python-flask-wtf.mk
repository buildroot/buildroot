################################################################################
#
# python-flask-wtf
#
################################################################################

PYTHON_FLASK_WTF_VERSION = 1.0.1
PYTHON_FLASK_WTF_SOURCE = Flask-WTF-$(PYTHON_FLASK_WTF_VERSION).tar.gz
PYTHON_FLASK_WTF_SITE = https://files.pythonhosted.org/packages/d9/38/d4798dd05be711d666e1befb08b1d3db57bd146d1a14d15657f60c88b446
PYTHON_FLASK_WTF_LICENSE = BSD-3-Clause
PYTHON_FLASK_WTF_LICENSE_FILES = LICENSE.rst
PYTHON_FLASK_WTF_SETUP_TYPE = setuptools

$(eval $(python-package))

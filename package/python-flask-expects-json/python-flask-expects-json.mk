################################################################################
#
# python-flask-expects-json
#
################################################################################

PYTHON_FLASK_EXPECTS_JSON_VERSION = 1.7.0
PYTHON_FLASK_EXPECTS_JSON_SOURCE = flask-expects-json-$(PYTHON_FLASK_EXPECTS_JSON_VERSION).tar.gz
PYTHON_FLASK_EXPECTS_JSON_SITE = https://files.pythonhosted.org/packages/12/a5/b27cf21d62c2b5a0a32e2f92bde9658e74c34fcc2e004bb0d591f1bf7627
PYTHON_FLASK_EXPECTS_JSON_SETUP_TYPE = setuptools
PYTHON_FLASK_EXPECTS_JSON_LICENSE = MIT
PYTHON_FLASK_EXPECTS_JSON_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

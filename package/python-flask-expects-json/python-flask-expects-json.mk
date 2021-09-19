################################################################################
#
# python-flask-expects-json
#
################################################################################

PYTHON_FLASK_EXPECTS_JSON_VERSION = 1.5.0
PYTHON_FLASK_EXPECTS_JSON_SOURCE = flask-expects-json-$(PYTHON_FLASK_EXPECTS_JSON_VERSION).tar.gz
PYTHON_FLASK_EXPECTS_JSON_SITE = https://files.pythonhosted.org/packages/4c/4a/9d9d050af700fb3feebd1f8466e73d65ce8b4709f27773e07100b0993451
PYTHON_FLASK_EXPECTS_JSON_SETUP_TYPE = setuptools
PYTHON_FLASK_EXPECTS_JSON_LICENSE = MIT
PYTHON_FLASK_EXPECTS_JSON_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

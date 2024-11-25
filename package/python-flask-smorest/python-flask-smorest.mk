################################################################################
#
# python-flask-smorest
#
################################################################################

PYTHON_FLASK_SMOREST_VERSION = 0.45.0
PYTHON_FLASK_SMOREST_SOURCE = flask_smorest-$(PYTHON_FLASK_SMOREST_VERSION).tar.gz
PYTHON_FLASK_SMOREST_SITE = https://files.pythonhosted.org/packages/29/cc/ad32be9d2a2148000c4c845d234f12cee10d6ec9cc3724fe7a3ff9e93f99
PYTHON_FLASK_SMOREST_SETUP_TYPE = flit
PYTHON_FLASK_SMOREST_LICENSE = MIT
PYTHON_FLASK_SMOREST_LICENSE_FILES = LICENSE

$(eval $(python-package))

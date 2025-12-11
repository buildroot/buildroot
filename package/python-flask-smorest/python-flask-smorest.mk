################################################################################
#
# python-flask-smorest
#
################################################################################

PYTHON_FLASK_SMOREST_VERSION = 0.46.2
PYTHON_FLASK_SMOREST_SOURCE = flask_smorest-$(PYTHON_FLASK_SMOREST_VERSION).tar.gz
PYTHON_FLASK_SMOREST_SITE = https://files.pythonhosted.org/packages/20/09/70074c15a9644a1def601b4fc78c114d4b2f4275310bc3476d1411da3003
PYTHON_FLASK_SMOREST_SETUP_TYPE = flit
PYTHON_FLASK_SMOREST_LICENSE = MIT
PYTHON_FLASK_SMOREST_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-flask-restx
#
################################################################################

PYTHON_FLASK_RESTX_VERSION = 1.3.2
PYTHON_FLASK_RESTX_SOURCE = flask-restx-$(PYTHON_FLASK_RESTX_VERSION).tar.gz
PYTHON_FLASK_RESTX_SITE = https://files.pythonhosted.org/packages/43/89/9b9ca58cbb8e9ec46f4a510ba93878e0c88d518bf03c350e3b1b7ad85cbe
PYTHON_FLASK_RESTX_SETUP_TYPE = setuptools
PYTHON_FLASK_RESTX_LICENSE = BSD-3-Clause
PYTHON_FLASK_RESTX_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-flask-restx
#
################################################################################

PYTHON_FLASK_RESTX_VERSION = 1.3.0
PYTHON_FLASK_RESTX_SOURCE = flask-restx-$(PYTHON_FLASK_RESTX_VERSION).tar.gz
PYTHON_FLASK_RESTX_SITE = https://files.pythonhosted.org/packages/45/4c/2e7d84e2b406b47cf3bf730f521efe474977b404ee170d8ea68dc37e6733
PYTHON_FLASK_RESTX_SETUP_TYPE = setuptools
PYTHON_FLASK_RESTX_LICENSE = BSD-3-Clause
PYTHON_FLASK_RESTX_LICENSE_FILES = LICENSE

$(eval $(python-package))

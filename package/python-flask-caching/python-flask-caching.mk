################################################################################
#
# python-flask-caching
#
################################################################################

PYTHON_FLASK_CACHING_VERSION = 2.4.0
PYTHON_FLASK_CACHING_SOURCE = flask_caching-$(PYTHON_FLASK_CACHING_VERSION).tar.gz
PYTHON_FLASK_CACHING_SITE = https://files.pythonhosted.org/packages/42/53/5c46b6a80adc13ed9179879a93cfc2c1f190c64c48ba732b4f5819df520e
PYTHON_FLASK_CACHING_SETUP_TYPE = setuptools
PYTHON_FLASK_CACHING_LICENSE = BSD-3-Clause
PYTHON_FLASK_CACHING_LICENSE_FILES = LICENSE docs/license.rst

$(eval $(python-package))

################################################################################
#
# python-flask-caching
#
################################################################################

PYTHON_FLASK_CACHING_VERSION = 2.3.1
PYTHON_FLASK_CACHING_SOURCE = flask_caching-$(PYTHON_FLASK_CACHING_VERSION).tar.gz
PYTHON_FLASK_CACHING_SITE = https://files.pythonhosted.org/packages/e2/80/74846c8af58ed60972d64f23a6cd0c3ac0175677d7555dff9f51bf82c294
PYTHON_FLASK_CACHING_SETUP_TYPE = setuptools
PYTHON_FLASK_CACHING_LICENSE = BSD-3-Clause
PYTHON_FLASK_CACHING_LICENSE_FILES = LICENSE docs/license.rst

$(eval $(python-package))

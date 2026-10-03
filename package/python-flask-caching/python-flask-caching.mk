################################################################################
#
# python-flask-caching
#
################################################################################

PYTHON_FLASK_CACHING_VERSION = 2.5.1
PYTHON_FLASK_CACHING_SOURCE = flask_caching-$(PYTHON_FLASK_CACHING_VERSION).tar.gz
PYTHON_FLASK_CACHING_SITE = https://files.pythonhosted.org/packages/a2/74/37c0cfc97444bc639a2854808c55ef61266c3637ab0a64c794b9f6ea1649
PYTHON_FLASK_CACHING_SETUP_TYPE = setuptools
PYTHON_FLASK_CACHING_LICENSE = BSD-3-Clause
PYTHON_FLASK_CACHING_LICENSE_FILES = LICENSE docs/license.rst

$(eval $(python-package))

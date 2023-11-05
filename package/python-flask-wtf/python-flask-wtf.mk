################################################################################
#
# python-flask-wtf
#
################################################################################

PYTHON_FLASK_WTF_VERSION = 1.2.1
PYTHON_FLASK_WTF_SOURCE = flask_wtf-$(PYTHON_FLASK_WTF_VERSION).tar.gz
PYTHON_FLASK_WTF_SITE = https://files.pythonhosted.org/packages/9b/ef/b6ec35e02f479f6e76e02ede14594c9cfa5e6dcbab6ea0e82fa413993a2a
PYTHON_FLASK_WTF_LICENSE = BSD-3-Clause
PYTHON_FLASK_WTF_LICENSE_FILES = LICENSE.rst
PYTHON_FLASK_WTF_SETUP_TYPE = setuptools

$(eval $(python-package))

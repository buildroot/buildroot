################################################################################
#
# python-flask-wtf
#
################################################################################

PYTHON_FLASK_WTF_VERSION = 1.2.2
PYTHON_FLASK_WTF_SOURCE = flask_wtf-$(PYTHON_FLASK_WTF_VERSION).tar.gz
PYTHON_FLASK_WTF_SITE = https://files.pythonhosted.org/packages/80/9b/f1cd6e41bbf874f3436368f2c7ee3216c1e82d666ff90d1d800e20eb1317
PYTHON_FLASK_WTF_LICENSE = BSD-3-Clause
PYTHON_FLASK_WTF_LICENSE_FILES = LICENSE.rst
PYTHON_FLASK_WTF_SETUP_TYPE = hatch

$(eval $(python-package))

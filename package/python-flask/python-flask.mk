################################################################################
#
# python-flask
#
################################################################################

PYTHON_FLASK_VERSION = 2.3.2
PYTHON_FLASK_SOURCE = Flask-$(PYTHON_FLASK_VERSION).tar.gz
PYTHON_FLASK_SITE = https://files.pythonhosted.org/packages/4d/00/ef81c18da32fdfcde6381c315f4b11597fb6691180a330418848efee0ae7
PYTHON_FLASK_SETUP_TYPE = setuptools
PYTHON_FLASK_LICENSE = BSD-3-Clause
PYTHON_FLASK_LICENSE_FILES = LICENSE.rst docs/license.rst
PYTHON_FLASK_CPE_ID_VENDOR = palletsprojects
PYTHON_FLASK_CPE_ID_PRODUCT = flask

$(eval $(python-package))

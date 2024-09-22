################################################################################
#
# python-werkzeug
#
################################################################################

PYTHON_WERKZEUG_VERSION = 3.0.4
PYTHON_WERKZEUG_SOURCE = werkzeug-$(PYTHON_WERKZEUG_VERSION).tar.gz
PYTHON_WERKZEUG_SITE = https://files.pythonhosted.org/packages/0f/e2/6dbcaab07560909ff8f654d3a2e5a60552d937c909455211b1b36d7101dc
PYTHON_WERKZEUG_SETUP_TYPE = flit
PYTHON_WERKZEUG_LICENSE = BSD-3-Clause
PYTHON_WERKZEUG_LICENSE_FILES = LICENSE.txt
PYTHON_WERKZEUG_CPE_ID_VENDOR = palletsprojects
PYTHON_WERKZEUG_CPE_ID_PRODUCT = werkzeug

$(eval $(python-package))

################################################################################
#
# python-werkzeug
#
################################################################################

PYTHON_WERKZEUG_VERSION = 3.1.3
PYTHON_WERKZEUG_SOURCE = werkzeug-$(PYTHON_WERKZEUG_VERSION).tar.gz
PYTHON_WERKZEUG_SITE = https://files.pythonhosted.org/packages/9f/69/83029f1f6300c5fb2471d621ab06f6ec6b3324685a2ce0f9777fd4a8b71e
PYTHON_WERKZEUG_SETUP_TYPE = flit
PYTHON_WERKZEUG_LICENSE = BSD-3-Clause
PYTHON_WERKZEUG_LICENSE_FILES = LICENSE.txt
PYTHON_WERKZEUG_CPE_ID_VENDOR = palletsprojects
PYTHON_WERKZEUG_CPE_ID_PRODUCT = werkzeug

$(eval $(python-package))

################################################################################
#
# python-werkzeug
#
################################################################################

PYTHON_WERKZEUG_VERSION = 3.1.4
PYTHON_WERKZEUG_SOURCE = werkzeug-$(PYTHON_WERKZEUG_VERSION).tar.gz
PYTHON_WERKZEUG_SITE = https://files.pythonhosted.org/packages/45/ea/b0f8eeb287f8df9066e56e831c7824ac6bab645dd6c7a8f4b2d767944f9b
PYTHON_WERKZEUG_SETUP_TYPE = flit
PYTHON_WERKZEUG_LICENSE = BSD-3-Clause
PYTHON_WERKZEUG_LICENSE_FILES = LICENSE.txt
PYTHON_WERKZEUG_CPE_ID_VENDOR = palletsprojects
PYTHON_WERKZEUG_CPE_ID_PRODUCT = werkzeug

$(eval $(python-package))

################################################################################
#
# python-werkzeug
#
################################################################################

PYTHON_WERKZEUG_VERSION = 3.0.6
PYTHON_WERKZEUG_SOURCE = werkzeug-$(PYTHON_WERKZEUG_VERSION).tar.gz
PYTHON_WERKZEUG_SITE = https://files.pythonhosted.org/packages/d4/f9/0ba83eaa0df9b9e9d1efeb2ea351d0677c37d41ee5d0f91e98423c7281c9
PYTHON_WERKZEUG_SETUP_TYPE = flit
PYTHON_WERKZEUG_LICENSE = BSD-3-Clause
PYTHON_WERKZEUG_LICENSE_FILES = LICENSE.txt
PYTHON_WERKZEUG_CPE_ID_VENDOR = palletsprojects
PYTHON_WERKZEUG_CPE_ID_PRODUCT = werkzeug

$(eval $(python-package))

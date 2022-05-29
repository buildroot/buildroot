################################################################################
#
# python-werkzeug
#
################################################################################

PYTHON_WERKZEUG_VERSION = 2.1.2
PYTHON_WERKZEUG_SOURCE = Werkzeug-$(PYTHON_WERKZEUG_VERSION).tar.gz
PYTHON_WERKZEUG_SITE = https://files.pythonhosted.org/packages/10/cf/97eb1a3847c01ae53e8376bc21145555ac95279523a935963dc8ff96c50b
PYTHON_WERKZEUG_SETUP_TYPE = setuptools
PYTHON_WERKZEUG_LICENSE = BSD-3-Clause
PYTHON_WERKZEUG_LICENSE_FILES = LICENSE.rst
PYTHON_WERKZEUG_CPE_ID_VENDOR = palletsprojects
PYTHON_WERKZEUG_CPE_ID_PRODUCT = werkzeug

$(eval $(python-package))

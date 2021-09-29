################################################################################
#
# python-dialog3
#
################################################################################

PYTHON_DIALOG3_VERSION = 3.5.1
PYTHON_DIALOG3_SOURCE = pythondialog-$(PYTHON_DIALOG3_VERSION).tar.gz
PYTHON_DIALOG3_SITE = https://files.pythonhosted.org/packages/72/3c/26ed0db035f97196704d0197d8b2254b8a6ca93a2d132430b0b0d597aa79
PYTHON_DIALOG3_LICENSE = LGPL-2.1+
PYTHON_DIALOG3_LICENSE_FILES = COPYING
PYTHON_DIALOG3_SETUP_TYPE = setuptools
PYTHON_DIALOG3_DEPENDENCIES = dialog

$(eval $(python-package))

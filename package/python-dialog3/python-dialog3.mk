################################################################################
#
# python-dialog3
#
################################################################################

PYTHON_DIALOG3_VERSION = 3.5.3
PYTHON_DIALOG3_SOURCE = pythondialog-$(PYTHON_DIALOG3_VERSION).tar.gz
PYTHON_DIALOG3_SITE = https://files.pythonhosted.org/packages/4e/40/5c84d79f7d536ca2c3722af521eff4faafe54a93797f08c72eb72e68fb68
PYTHON_DIALOG3_LICENSE = LGPL-2.1+
PYTHON_DIALOG3_LICENSE_FILES = COPYING
PYTHON_DIALOG3_SETUP_TYPE = setuptools
PYTHON_DIALOG3_DEPENDENCIES = dialog

$(eval $(python-package))

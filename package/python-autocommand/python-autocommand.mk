################################################################################
#
# python-autocommand
#
################################################################################

PYTHON_AUTOCOMMAND_VERSION = 2.2.2
PYTHON_AUTOCOMMAND_SOURCE = autocommand-$(PYTHON_AUTOCOMMAND_VERSION).tar.gz
PYTHON_AUTOCOMMAND_SITE = https://files.pythonhosted.org/packages/5b/18/774bddb96bc0dc0a2b8ac2d2a0e686639744378883da0fc3b96a54192d7a
PYTHON_AUTOCOMMAND_SETUP_TYPE = setuptools
PYTHON_AUTOCOMMAND_LICENSE = LGPL-3.0+
PYTHON_AUTOCOMMAND_LICENSE_FILES = LICENSE

$(eval $(python-package))

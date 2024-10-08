################################################################################
#
# python-watchdog
#
################################################################################

PYTHON_WATCHDOG_VERSION = 5.0.3
PYTHON_WATCHDOG_SOURCE = watchdog-$(PYTHON_WATCHDOG_VERSION).tar.gz
PYTHON_WATCHDOG_SITE = https://files.pythonhosted.org/packages/a2/48/a86139aaeab2db0a2482676f64798d8ac4d2dbb457523f50ab37bf02ce2c
PYTHON_WATCHDOG_SETUP_TYPE = setuptools
PYTHON_WATCHDOG_LICENSE = Apache-2.0
PYTHON_WATCHDOG_LICENSE_FILES = LICENSE COPYING

$(eval $(python-package))

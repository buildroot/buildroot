################################################################################
#
# python-watchdog
#
################################################################################

PYTHON_WATCHDOG_VERSION = 7.0.0
PYTHON_WATCHDOG_SOURCE = watchdog-$(PYTHON_WATCHDOG_VERSION).tar.gz
PYTHON_WATCHDOG_SITE = https://files.pythonhosted.org/packages/92/68/6477c65315fd5b58ea5c7fbfe871c3ca6e5ec951be6c48c2f5fe8ee5e34d
PYTHON_WATCHDOG_SETUP_TYPE = setuptools
PYTHON_WATCHDOG_LICENSE = Apache-2.0
PYTHON_WATCHDOG_LICENSE_FILES = LICENSE COPYING

$(eval $(python-package))

################################################################################
#
# python-watchdog
#
################################################################################

PYTHON_WATCHDOG_VERSION = 5.0.2
PYTHON_WATCHDOG_SOURCE = watchdog-$(PYTHON_WATCHDOG_VERSION).tar.gz
PYTHON_WATCHDOG_SITE = https://files.pythonhosted.org/packages/cd/5e/95dcd86d8339fcf76385f7fad5e49cbfd989b6c6199127121c9587febc65
PYTHON_WATCHDOG_SETUP_TYPE = setuptools
PYTHON_WATCHDOG_LICENSE = Apache-2.0
PYTHON_WATCHDOG_LICENSE_FILES = LICENSE COPYING

$(eval $(python-package))

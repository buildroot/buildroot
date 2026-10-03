################################################################################
#
# python-crontab
#
################################################################################

PYTHON_CRONTAB_VERSION = 3.4.0
PYTHON_CRONTAB_SOURCE = python_crontab-$(PYTHON_CRONTAB_VERSION).tar.gz
PYTHON_CRONTAB_SITE = https://files.pythonhosted.org/packages/49/3e/f61917a63b20d0ce0dfb58e44192201892a1cfe9d4167264b93fa5485594
PYTHON_CRONTAB_SETUP_TYPE = setuptools
PYTHON_CRONTAB_LICENSE = LGPL-3.0+
PYTHON_CRONTAB_LICENSE_FILES = COPYING

$(eval $(python-package))

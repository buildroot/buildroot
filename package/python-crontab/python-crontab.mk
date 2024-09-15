################################################################################
#
# python-crontab
#
################################################################################

PYTHON_CRONTAB_VERSION = 3.2.0
PYTHON_CRONTAB_SOURCE = python_crontab-$(PYTHON_CRONTAB_VERSION).tar.gz
PYTHON_CRONTAB_SITE = https://files.pythonhosted.org/packages/e2/f0/25775565c133d4e29eeb607bf9ddba0075f3af36041a1844dd207881047f
PYTHON_CRONTAB_SETUP_TYPE = setuptools
PYTHON_CRONTAB_LICENSE = LGPL-3.0+
PYTHON_CRONTAB_LICENSE_FILES = COPYING

$(eval $(python-package))

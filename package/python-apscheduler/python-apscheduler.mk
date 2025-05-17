################################################################################
#
# python-apscheduler
#
################################################################################

PYTHON_APSCHEDULER_VERSION = 3.11.0
PYTHON_APSCHEDULER_SOURCE = apscheduler-$(PYTHON_APSCHEDULER_VERSION).tar.gz
PYTHON_APSCHEDULER_SITE = https://files.pythonhosted.org/packages/4e/00/6d6814ddc19be2df62c8c898c4df6b5b1914f3bd024b780028caa392d186
PYTHON_APSCHEDULER_SETUP_TYPE = setuptools
PYTHON_APSCHEDULER_DEPENDENCIES = host-python-setuptools-scm
PYTHON_APSCHEDULER_LICENSE = MIT
PYTHON_APSCHEDULER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

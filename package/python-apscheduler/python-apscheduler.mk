################################################################################
#
# python-apscheduler
#
################################################################################

PYTHON_APSCHEDULER_VERSION = 3.11.2
PYTHON_APSCHEDULER_SOURCE = apscheduler-$(PYTHON_APSCHEDULER_VERSION).tar.gz
PYTHON_APSCHEDULER_SITE = https://files.pythonhosted.org/packages/07/12/3e4389e5920b4c1763390c6d371162f3784f86f85cd6d6c1bfe68eef14e2
PYTHON_APSCHEDULER_SETUP_TYPE = setuptools
PYTHON_APSCHEDULER_DEPENDENCIES = host-python-setuptools-scm
PYTHON_APSCHEDULER_LICENSE = MIT
PYTHON_APSCHEDULER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

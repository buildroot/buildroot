################################################################################
#
# python-schedule
#
################################################################################

PYTHON_SCHEDULE_VERSION = 1.2.2
PYTHON_SCHEDULE_SOURCE = schedule-$(PYTHON_SCHEDULE_VERSION).tar.gz
PYTHON_SCHEDULE_SITE = https://files.pythonhosted.org/packages/0c/91/b525790063015759f34447d4cf9d2ccb52cdee0f1dd6ff8764e863bcb74c
PYTHON_SCHEDULE_SETUP_TYPE = setuptools
PYTHON_SCHEDULE_LICENSE = MIT
PYTHON_SCHEDULE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

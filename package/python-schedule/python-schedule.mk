################################################################################
#
# python-schedule
#
################################################################################

PYTHON_SCHEDULE_VERSION = 1.2.1
PYTHON_SCHEDULE_SOURCE = schedule-$(PYTHON_SCHEDULE_VERSION).tar.gz
PYTHON_SCHEDULE_SITE = https://files.pythonhosted.org/packages/29/22/9dd374cbf76a42ece1f1f41cc8f4957f0ad512577372527cd3dd52758241
PYTHON_SCHEDULE_SETUP_TYPE = setuptools
PYTHON_SCHEDULE_LICENSE = MIT
PYTHON_SCHEDULE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

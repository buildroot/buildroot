################################################################################
#
# python-schedule
#
################################################################################

PYTHON_SCHEDULE_VERSION = 1.1.0
PYTHON_SCHEDULE_SOURCE = schedule-$(PYTHON_SCHEDULE_VERSION).tar.gz
PYTHON_SCHEDULE_SITE = https://files.pythonhosted.org/packages/a8/b5/a291a4c0faa491fd5baefa6d89011ece581cff47b23c0a39b42a63383358
PYTHON_SCHEDULE_SETUP_TYPE = setuptools
PYTHON_SCHEDULE_LICENSE = MIT
PYTHON_SCHEDULE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

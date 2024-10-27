################################################################################
#
# python-logbook
#
################################################################################

PYTHON_LOGBOOK_VERSION = 1.8.0
PYTHON_LOGBOOK_SOURCE = logbook-$(PYTHON_LOGBOOK_VERSION).tar.gz
PYTHON_LOGBOOK_SITE = https://files.pythonhosted.org/packages/c3/a2/fafcc4ce7bad34093150e14f9ed179aa53e3e60a5c46e840547bdae26674
PYTHON_LOGBOOK_SETUP_TYPE = setuptools
PYTHON_LOGBOOK_LICENSE = BSD-3-Clause
PYTHON_LOGBOOK_LICENSE_FILES = LICENSE
PYTHON_LOGBOOK_DEPENDENCIES = host-python-cython

$(eval $(python-package))

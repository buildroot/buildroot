################################################################################
#
# python-logbook
#
################################################################################

PYTHON_LOGBOOK_VERSION = 1.7.0.post0
PYTHON_LOGBOOK_SOURCE = Logbook-$(PYTHON_LOGBOOK_VERSION).tar.gz
PYTHON_LOGBOOK_SITE = https://files.pythonhosted.org/packages/cc/98/c1d93c1d7593f58515333a6217aa4ae647d9ee9c1aa2dfdf77b28b7bb7c7
PYTHON_LOGBOOK_SETUP_TYPE = setuptools
PYTHON_LOGBOOK_LICENSE = BSD-3-Clause
PYTHON_LOGBOOK_LICENSE_FILES = LICENSE
PYTHON_LOGBOOK_DEPENDENCIES = host-python-cython

$(eval $(python-package))

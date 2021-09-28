################################################################################
#
# python-priority
#
################################################################################

PYTHON_PRIORITY_VERSION = 2.0.0
PYTHON_PRIORITY_SOURCE = priority-$(PYTHON_PRIORITY_VERSION).tar.gz
PYTHON_PRIORITY_SITE = https://files.pythonhosted.org/packages/f5/3c/eb7c35f4dcede96fca1842dac5f4f5d15511aa4b52f3a961219e68ae9204
PYTHON_PRIORITY_SETUP_TYPE = setuptools
PYTHON_PRIORITY_LICENSE = MIT
PYTHON_PRIORITY_LICENSE_FILES = LICENSE

$(eval $(python-package))

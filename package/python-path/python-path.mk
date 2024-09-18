################################################################################
#
# python-path
#
################################################################################

PYTHON_PATH_VERSION = 17.0.0
PYTHON_PATH_SOURCE = path-$(PYTHON_PATH_VERSION).tar.gz
PYTHON_PATH_SITE = https://files.pythonhosted.org/packages/ff/a3/5dac44ce60ad6543578736a5729c5c2130cdac1c3117c61aad0583c2e3c6
PYTHON_PATH_SETUP_TYPE = setuptools
PYTHON_PATH_LICENSE = MIT
PYTHON_PATH_LICENSE_FILES = LICENSE
PYTHON_PATH_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

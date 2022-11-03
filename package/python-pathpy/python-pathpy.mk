################################################################################
#
# python-pathpy
#
################################################################################

PYTHON_PATHPY_VERSION = 12.5.0
PYTHON_PATHPY_SOURCE = path.py-$(PYTHON_PATHPY_VERSION).tar.gz
PYTHON_PATHPY_SITE = https://files.pythonhosted.org/packages/b6/e3/81be70016d58ade0f516191fa80152daba5453d0b07ce648d9daae86a188
PYTHON_PATHPY_SETUP_TYPE = setuptools
PYTHON_PATHPY_LICENSE = MIT
PYTHON_PATHPY_LICENSE_FILES = LICENSE
PYTHON_PATHPY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

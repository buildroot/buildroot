################################################################################
#
# python-pyftpdlib
#
################################################################################

PYTHON_PYFTPDLIB_VERSION = 1.5.6
PYTHON_PYFTPDLIB_SOURCE = pyftpdlib-$(PYTHON_PYFTPDLIB_VERSION).tar.gz
PYTHON_PYFTPDLIB_SITE = https://files.pythonhosted.org/packages/31/61/63ef60aca6de07eba1639d9d47f3f8e29462e8bb49d6a8dce9aeff240646
PYTHON_PYFTPDLIB_SETUP_TYPE = setuptools
PYTHON_PYFTPDLIB_LICENSE = MIT
PYTHON_PYFTPDLIB_LICENSE_FILES = LICENSE

$(eval $(python-package))

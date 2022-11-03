################################################################################
#
# python-pyftpdlib
#
################################################################################

PYTHON_PYFTPDLIB_VERSION = 1.5.7
PYTHON_PYFTPDLIB_SOURCE = pyftpdlib-$(PYTHON_PYFTPDLIB_VERSION).tar.gz
PYTHON_PYFTPDLIB_SITE = https://files.pythonhosted.org/packages/2f/bc/f03a15bf807698bbecdcf316041e3d79b25a40fa7b6e071e17702ff7b9d4
PYTHON_PYFTPDLIB_SETUP_TYPE = setuptools
PYTHON_PYFTPDLIB_LICENSE = MIT
PYTHON_PYFTPDLIB_LICENSE_FILES = LICENSE

$(eval $(python-package))

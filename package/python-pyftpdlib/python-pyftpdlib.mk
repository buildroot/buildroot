################################################################################
#
# python-pyftpdlib
#
################################################################################

PYTHON_PYFTPDLIB_VERSION = 2.1.0
PYTHON_PYFTPDLIB_SOURCE = pyftpdlib-$(PYTHON_PYFTPDLIB_VERSION).tar.gz
PYTHON_PYFTPDLIB_SITE = https://files.pythonhosted.org/packages/fc/67/3299ce20585601d21e05153eb9275cb799ae408fe15ab93e48e4582ea9fe
PYTHON_PYFTPDLIB_SETUP_TYPE = setuptools
PYTHON_PYFTPDLIB_LICENSE = MIT
PYTHON_PYFTPDLIB_LICENSE_FILES = LICENSE

$(eval $(python-package))

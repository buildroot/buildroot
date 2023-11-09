################################################################################
#
# python-mypy-extensions
#
################################################################################

PYTHON_MYPY_EXTENSIONS_VERSION = 1.0.0
PYTHON_MYPY_EXTENSIONS_SOURCE = mypy_extensions-$(PYTHON_MYPY_EXTENSIONS_VERSION).tar.gz
PYTHON_MYPY_EXTENSIONS_SITE = https://files.pythonhosted.org/packages/98/a4/1ab47638b92648243faf97a5aeb6ea83059cc3624972ab6b8d2316078d3f
PYTHON_MYPY_EXTENSIONS_SETUP_TYPE = setuptools
PYTHON_MYPY_EXTENSIONS_LICENSE = MIT
PYTHON_MYPY_EXTENSIONS_LICENSE_FILES = LICENSE

$(eval $(python-package))

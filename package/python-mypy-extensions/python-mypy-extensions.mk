################################################################################
#
# python-mypy-extensions
#
################################################################################

PYTHON_MYPY_EXTENSIONS_VERSION = 1.1.0
PYTHON_MYPY_EXTENSIONS_SOURCE = mypy_extensions-$(PYTHON_MYPY_EXTENSIONS_VERSION).tar.gz
PYTHON_MYPY_EXTENSIONS_SITE = https://files.pythonhosted.org/packages/a2/6e/371856a3fb9d31ca8dac321cda606860fa4548858c0cc45d9d1d4ca2628b
PYTHON_MYPY_EXTENSIONS_SETUP_TYPE = flit
PYTHON_MYPY_EXTENSIONS_LICENSE = MIT
PYTHON_MYPY_EXTENSIONS_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))

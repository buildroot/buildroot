################################################################################
#
# python-mypy-extensions
#
################################################################################

PYTHON_MYPY_EXTENSIONS_VERSION = 1.2.0
PYTHON_MYPY_EXTENSIONS_SOURCE = mypy_extensions-$(PYTHON_MYPY_EXTENSIONS_VERSION).tar.gz
PYTHON_MYPY_EXTENSIONS_SITE = https://files.pythonhosted.org/packages/d0/6f/43edf3be2748d0e40974a5ee046a8bb4c9961a4bdd3e7d5c6dcbf32d1af6
PYTHON_MYPY_EXTENSIONS_SETUP_TYPE = flit
PYTHON_MYPY_EXTENSIONS_LICENSE = MIT
PYTHON_MYPY_EXTENSIONS_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))

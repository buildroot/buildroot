################################################################################
#
# python-mypy-extensions
#
################################################################################

PYTHON_MYPY_EXTENSIONS_VERSION = 0.4.3
PYTHON_MYPY_EXTENSIONS_SOURCE = mypy_extensions-$(PYTHON_MYPY_EXTENSIONS_VERSION).tar.gz
PYTHON_MYPY_EXTENSIONS_SITE = https://files.pythonhosted.org/packages/63/60/0582ce2eaced55f65a4406fc97beba256de4b7a95a0034c6576458c6519f
PYTHON_MYPY_EXTENSIONS_SETUP_TYPE = setuptools
PYTHON_MYPY_EXTENSIONS_LICENSE = MIT
PYTHON_MYPY_EXTENSIONS_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-typing-extensions
#
################################################################################

PYTHON_TYPING_EXTENSIONS_VERSION = 4.9.0
PYTHON_TYPING_EXTENSIONS_SOURCE = typing_extensions-$(PYTHON_TYPING_EXTENSIONS_VERSION).tar.gz
PYTHON_TYPING_EXTENSIONS_SITE = https://files.pythonhosted.org/packages/0c/1d/eb26f5e75100d531d7399ae800814b069bc2ed2a7410834d57374d010d96
PYTHON_TYPING_EXTENSIONS_SETUP_TYPE = flit
PYTHON_TYPING_EXTENSIONS_LICENSE = Python-2.0
PYTHON_TYPING_EXTENSIONS_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))

################################################################################
#
# python-typing-extensions
#
################################################################################

PYTHON_TYPING_EXTENSIONS_VERSION = 4.2.0
PYTHON_TYPING_EXTENSIONS_SOURCE = typing_extensions-$(PYTHON_TYPING_EXTENSIONS_VERSION).tar.gz
PYTHON_TYPING_EXTENSIONS_SITE = https://files.pythonhosted.org/packages/fe/71/1df93bd59163c8084d812d166c907639646e8aac72886d563851b966bf18
PYTHON_TYPING_EXTENSIONS_SETUP_TYPE = flit
PYTHON_TYPING_EXTENSIONS_LICENSE = Python-2.0
PYTHON_TYPING_EXTENSIONS_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))

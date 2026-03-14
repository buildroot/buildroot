################################################################################
#
# python-textual
#
################################################################################

PYTHON_TEXTUAL_VERSION = 8.1.1
PYTHON_TEXTUAL_SOURCE = textual-$(PYTHON_TEXTUAL_VERSION).tar.gz
PYTHON_TEXTUAL_SITE = https://files.pythonhosted.org/packages/72/23/8c709655c5f2208ee82ab81b8104802421865535c278a7649b842b129db1
PYTHON_TEXTUAL_SETUP_TYPE = poetry
PYTHON_TEXTUAL_LICENSE = MIT
PYTHON_TEXTUAL_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-textual
#
################################################################################

PYTHON_TEXTUAL_VERSION = 7.5.0
PYTHON_TEXTUAL_SOURCE = textual-$(PYTHON_TEXTUAL_VERSION).tar.gz
PYTHON_TEXTUAL_SITE = https://files.pythonhosted.org/packages/9f/38/7d169a765993efde5095c70a668bf4f5831bb7ac099e932f2783e9b71abf
PYTHON_TEXTUAL_SETUP_TYPE = poetry
PYTHON_TEXTUAL_LICENSE = MIT
PYTHON_TEXTUAL_LICENSE_FILES = LICENSE

$(eval $(python-package))

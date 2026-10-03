################################################################################
#
# python-textual
#
################################################################################

PYTHON_TEXTUAL_VERSION = 8.2.8
PYTHON_TEXTUAL_SOURCE = textual-$(PYTHON_TEXTUAL_VERSION).tar.gz
PYTHON_TEXTUAL_SITE = https://files.pythonhosted.org/packages/00/21/39a76b01bd5eea82a04baaca7580e105d8c59450df03998345bb2cfb307b
PYTHON_TEXTUAL_SETUP_TYPE = poetry
PYTHON_TEXTUAL_LICENSE = MIT
PYTHON_TEXTUAL_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-fastui
#
################################################################################

PYTHON_FASTUI_VERSION = 0.5.2
PYTHON_FASTUI_SOURCE = fastui-$(PYTHON_FASTUI_VERSION).tar.gz
PYTHON_FASTUI_SITE = https://files.pythonhosted.org/packages/64/11/515c9b5cb6e885f4ba8c325f75b95a754d99b8296bdc9f134dc90a79019f
PYTHON_FASTUI_SETUP_TYPE = pep517
PYTHON_FASTUI_LICENSE = MIT
PYTHON_FASTUI_LICENSE_FILES = LICENSE
PYTHON_FASTUI_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))

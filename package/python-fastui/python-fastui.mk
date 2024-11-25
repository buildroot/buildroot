################################################################################
#
# python-fastui
#
################################################################################

PYTHON_FASTUI_VERSION = 0.7.0
PYTHON_FASTUI_SOURCE = fastui-$(PYTHON_FASTUI_VERSION).tar.gz
PYTHON_FASTUI_SITE = https://files.pythonhosted.org/packages/87/97/3f001410200256026ff98a4588ec8cb4f3b48bc74a28325e32bfb3b08ffd
PYTHON_FASTUI_SETUP_TYPE = hatch
PYTHON_FASTUI_LICENSE = MIT
PYTHON_FASTUI_LICENSE_FILES = LICENSE

$(eval $(python-package))

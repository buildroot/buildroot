################################################################################
#
# python-fastui
#
################################################################################

PYTHON_FASTUI_VERSION = 0.9.0
PYTHON_FASTUI_SOURCE = fastui-$(PYTHON_FASTUI_VERSION).tar.gz
PYTHON_FASTUI_SITE = https://files.pythonhosted.org/packages/c4/27/e52de3e3a3dd16cda6fac11d2b5b0ed8a54e14386a303bc8f757275df121
PYTHON_FASTUI_SETUP_TYPE = hatch
PYTHON_FASTUI_LICENSE = MIT
PYTHON_FASTUI_LICENSE_FILES = LICENSE

$(eval $(python-package))

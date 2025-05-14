################################################################################
#
# python-typing-inspection
#
################################################################################

PYTHON_TYPING_INSPECTION_VERSION = 0.4.0
PYTHON_TYPING_INSPECTION_SOURCE = typing_inspection-$(PYTHON_TYPING_INSPECTION_VERSION).tar.gz
PYTHON_TYPING_INSPECTION_SITE = https://files.pythonhosted.org/packages/82/5c/e6082df02e215b846b4b8c0b887a64d7d08ffaba30605502639d44c06b82
PYTHON_TYPING_INSPECTION_SETUP_TYPE = hatch
PYTHON_TYPING_INSPECTION_LICENSE = MIT
PYTHON_TYPING_INSPECTION_LICENSE_FILES = LICENSE

$(eval $(python-package))

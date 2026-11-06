################################################################################
#
# python-typing-inspection
#
################################################################################

PYTHON_TYPING_INSPECTION_VERSION = 0.4.5
PYTHON_TYPING_INSPECTION_SOURCE = typing_inspection-$(PYTHON_TYPING_INSPECTION_VERSION).tar.gz
PYTHON_TYPING_INSPECTION_SITE = https://files.pythonhosted.org/packages/ff/50/0195198eb1d75bab716bb0a813abea4cc394bfa17a92a189f021a34859af
PYTHON_TYPING_INSPECTION_SETUP_TYPE = hatch
PYTHON_TYPING_INSPECTION_LICENSE = MIT
PYTHON_TYPING_INSPECTION_LICENSE_FILES = LICENSE

$(eval $(python-package))

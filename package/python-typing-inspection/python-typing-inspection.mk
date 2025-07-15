################################################################################
#
# python-typing-inspection
#
################################################################################

PYTHON_TYPING_INSPECTION_VERSION = 0.4.1
PYTHON_TYPING_INSPECTION_SOURCE = typing_inspection-$(PYTHON_TYPING_INSPECTION_VERSION).tar.gz
PYTHON_TYPING_INSPECTION_SITE = https://files.pythonhosted.org/packages/f8/b1/0c11f5058406b3af7609f121aaa6b609744687f1d158b3c3a5bf4cc94238
PYTHON_TYPING_INSPECTION_SETUP_TYPE = hatch
PYTHON_TYPING_INSPECTION_LICENSE = MIT
PYTHON_TYPING_INSPECTION_LICENSE_FILES = LICENSE

$(eval $(python-package))

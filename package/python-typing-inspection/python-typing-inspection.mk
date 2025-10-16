################################################################################
#
# python-typing-inspection
#
################################################################################

PYTHON_TYPING_INSPECTION_VERSION = 0.4.2
PYTHON_TYPING_INSPECTION_SOURCE = typing_inspection-$(PYTHON_TYPING_INSPECTION_VERSION).tar.gz
PYTHON_TYPING_INSPECTION_SITE = https://files.pythonhosted.org/packages/55/e3/70399cb7dd41c10ac53367ae42139cf4b1ca5f36bb3dc6c9d33acdb43655
PYTHON_TYPING_INSPECTION_SETUP_TYPE = hatch
PYTHON_TYPING_INSPECTION_LICENSE = MIT
PYTHON_TYPING_INSPECTION_LICENSE_FILES = LICENSE

$(eval $(python-package))

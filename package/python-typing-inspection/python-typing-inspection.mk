################################################################################
#
# python-typing-inspection
#
################################################################################

PYTHON_TYPING_INSPECTION_VERSION = 0.4.4
PYTHON_TYPING_INSPECTION_SOURCE = typing_inspection-$(PYTHON_TYPING_INSPECTION_VERSION).tar.gz
PYTHON_TYPING_INSPECTION_SITE = https://files.pythonhosted.org/packages/a3/26/b09b8010994eccc3c09092e6b34058f36a460eea2d4c3e8b910c695975a0
PYTHON_TYPING_INSPECTION_SETUP_TYPE = hatch
PYTHON_TYPING_INSPECTION_LICENSE = MIT
PYTHON_TYPING_INSPECTION_LICENSE_FILES = LICENSE

$(eval $(python-package))

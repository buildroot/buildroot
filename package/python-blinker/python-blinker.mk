################################################################################
#
# python-blinker
#
################################################################################

PYTHON_BLINKER_VERSION = 1.8.2
PYTHON_BLINKER_SOURCE = blinker-$(PYTHON_BLINKER_VERSION).tar.gz
PYTHON_BLINKER_SITE = https://files.pythonhosted.org/packages/1e/57/a6a1721eff09598fb01f3c7cda070c1b6a0f12d63c83236edf79a440abcc
PYTHON_BLINKER_SETUP_TYPE = flit
PYTHON_BLINKER_LICENSE = MIT
PYTHON_BLINKER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

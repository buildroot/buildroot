################################################################################
#
# python-blinker
#
################################################################################

PYTHON_BLINKER_VERSION = 1.9.0
PYTHON_BLINKER_SOURCE = blinker-$(PYTHON_BLINKER_VERSION).tar.gz
PYTHON_BLINKER_SITE = https://files.pythonhosted.org/packages/21/28/9b3f50ce0e048515135495f198351908d99540d69bfdc8c1d15b73dc55ce
PYTHON_BLINKER_SETUP_TYPE = flit
PYTHON_BLINKER_LICENSE = MIT
PYTHON_BLINKER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

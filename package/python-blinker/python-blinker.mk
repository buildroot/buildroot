################################################################################
#
# python-blinker
#
################################################################################

PYTHON_BLINKER_VERSION = 1.6.2
PYTHON_BLINKER_SOURCE = blinker-$(PYTHON_BLINKER_VERSION).tar.gz
PYTHON_BLINKER_SITE = https://files.pythonhosted.org/packages/e8/f9/a05287f3d5c54d20f51a235ace01f50620984bc7ca5ceee781dc645211c5
PYTHON_BLINKER_SETUP_TYPE = setuptools
PYTHON_BLINKER_LICENSE = MIT
PYTHON_BLINKER_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

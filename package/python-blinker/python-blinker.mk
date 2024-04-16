################################################################################
#
# python-blinker
#
################################################################################

PYTHON_BLINKER_VERSION = 1.7.0
PYTHON_BLINKER_SOURCE = blinker-$(PYTHON_BLINKER_VERSION).tar.gz
PYTHON_BLINKER_SITE = https://files.pythonhosted.org/packages/a1/13/6df5fc090ff4e5d246baf1f45fe9e5623aa8565757dfa5bd243f6a545f9e
PYTHON_BLINKER_SETUP_TYPE = setuptools
PYTHON_BLINKER_LICENSE = MIT
PYTHON_BLINKER_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

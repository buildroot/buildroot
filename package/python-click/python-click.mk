################################################################################
#
# python-click
#
################################################################################

PYTHON_CLICK_VERSION = 8.1.7
PYTHON_CLICK_SOURCE = click-$(PYTHON_CLICK_VERSION).tar.gz
PYTHON_CLICK_SITE = https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5
PYTHON_CLICK_LICENSE = BSD-3-Clause
PYTHON_CLICK_LICENSE_FILES = LICENSE.rst
PYTHON_CLICK_SETUP_TYPE = setuptools

$(eval $(python-package))

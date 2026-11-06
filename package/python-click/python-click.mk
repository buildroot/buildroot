################################################################################
#
# python-click
#
################################################################################

PYTHON_CLICK_VERSION = 8.5.1
PYTHON_CLICK_SOURCE = click-$(PYTHON_CLICK_VERSION).tar.gz
PYTHON_CLICK_SITE = https://files.pythonhosted.org/packages/45/37/edbf1b0707709013c0cf2e8317e03d97ed29bf4cac709fe328904ae92a38
PYTHON_CLICK_SETUP_TYPE = flit
PYTHON_CLICK_LICENSE = BSD-3-Clause
PYTHON_CLICK_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

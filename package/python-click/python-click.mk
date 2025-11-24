################################################################################
#
# python-click
#
################################################################################

PYTHON_CLICK_VERSION = 8.3.1
PYTHON_CLICK_SOURCE = click-$(PYTHON_CLICK_VERSION).tar.gz
PYTHON_CLICK_SITE = https://files.pythonhosted.org/packages/3d/fa/656b739db8587d7b5dfa22e22ed02566950fbfbcdc20311993483657a5c0
PYTHON_CLICK_SETUP_TYPE = flit
PYTHON_CLICK_LICENSE = BSD-3-Clause
PYTHON_CLICK_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

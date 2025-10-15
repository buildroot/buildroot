################################################################################
#
# python-click
#
################################################################################

PYTHON_CLICK_VERSION = 8.3.0
PYTHON_CLICK_SOURCE = click-$(PYTHON_CLICK_VERSION).tar.gz
PYTHON_CLICK_SITE = https://files.pythonhosted.org/packages/46/61/de6cd827efad202d7057d93e0fed9294b96952e188f7384832791c7b2254
PYTHON_CLICK_SETUP_TYPE = flit
PYTHON_CLICK_LICENSE = BSD-3-Clause
PYTHON_CLICK_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

################################################################################
#
# python-click
#
################################################################################

PYTHON_CLICK_VERSION = 8.2.0
PYTHON_CLICK_SOURCE = click-$(PYTHON_CLICK_VERSION).tar.gz
PYTHON_CLICK_SITE = https://files.pythonhosted.org/packages/cd/0f/62ca20172d4f87d93cf89665fbaedcd560ac48b465bd1d92bfc7ea6b0a41
PYTHON_CLICK_SETUP_TYPE = flit
PYTHON_CLICK_LICENSE = BSD-3-Clause
PYTHON_CLICK_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

################################################################################
#
# python-tomli-w
#
################################################################################

PYTHON_TOMLI_W_VERSION = 1.1.0
PYTHON_TOMLI_W_SOURCE = tomli_w-$(PYTHON_TOMLI_W_VERSION).tar.gz
PYTHON_TOMLI_W_SITE = https://files.pythonhosted.org/packages/d4/19/b65f1a088ee23e37cdea415b357843eca8b1422a7b11a9eee6e35d4ec273
PYTHON_TOMLI_W_SETUP_TYPE = flit
PYTHON_TOMLI_W_LICENSE = MIT
PYTHON_TOMLI_W_LICENSE_FILES = LICENSE

$(eval $(python-package))

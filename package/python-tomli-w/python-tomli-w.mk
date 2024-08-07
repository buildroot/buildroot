################################################################################
#
# python-tomli-w
#
################################################################################

PYTHON_TOMLI_W_VERSION = 1.0.0
PYTHON_TOMLI_W_SOURCE = tomli_w-$(PYTHON_TOMLI_W_VERSION).tar.gz
PYTHON_TOMLI_W_SITE = https://files.pythonhosted.org/packages/49/05/6bf21838623186b91aedbda06248ad18f03487dc56fbc20e4db384abde6c
PYTHON_TOMLI_W_SETUP_TYPE = flit
PYTHON_TOMLI_W_LICENSE = MIT
PYTHON_TOMLI_W_LICENSE_FILES = LICENSE

$(eval $(python-package))

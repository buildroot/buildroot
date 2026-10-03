################################################################################
#
# python-pyparsing
#
################################################################################

PYTHON_PYPARSING_VERSION = 3.3.3
PYTHON_PYPARSING_SOURCE = pyparsing-$(PYTHON_PYPARSING_VERSION).tar.gz
PYTHON_PYPARSING_SITE = https://files.pythonhosted.org/packages/e4/11/b213bebff182584360cb8d17c72c1677fec5c5c228de439e63bcf8ab1c8f
PYTHON_PYPARSING_LICENSE = MIT
PYTHON_PYPARSING_LICENSE_FILES = LICENSE
PYTHON_PYPARSING_SETUP_TYPE = flit
HOST_PYTHON_PYPARSING_SETUP_TYPE = flit-bootstrap

$(eval $(python-package))
$(eval $(host-python-package))

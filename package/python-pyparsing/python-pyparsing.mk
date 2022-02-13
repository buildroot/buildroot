################################################################################
#
# python-pyparsing
#
################################################################################

PYTHON_PYPARSING_VERSION = 3.0.7
PYTHON_PYPARSING_SOURCE = pyparsing-$(PYTHON_PYPARSING_VERSION).tar.gz
PYTHON_PYPARSING_SITE = https://files.pythonhosted.org/packages/d6/60/9bed18f43275b34198eb9720d4c1238c68b3755620d20df0afd89424d32b
PYTHON_PYPARSING_LICENSE = MIT
PYTHON_PYPARSING_LICENSE_FILES = LICENSE
PYTHON_PYPARSING_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))

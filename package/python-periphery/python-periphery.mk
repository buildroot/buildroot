################################################################################
#
# python-periphery
#
################################################################################

PYTHON_PERIPHERY_VERSION = 2.4.2
PYTHON_PERIPHERY_SOURCE = python_periphery-$(PYTHON_PERIPHERY_VERSION).tar.gz
PYTHON_PERIPHERY_SITE = https://files.pythonhosted.org/packages/81/4e/e25e53c24192b7a6192f27ae38760dc679737b5b3c44961408e1ab10e802
PYTHON_PERIPHERY_LICENSE = MIT
PYTHON_PERIPHERY_LICENSE_FILES = LICENSE
PYTHON_PERIPHERY_SETUP_TYPE = setuptools

$(eval $(python-package))

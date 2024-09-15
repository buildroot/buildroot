################################################################################
#
# python-cssutils
#
################################################################################

PYTHON_CSSUTILS_VERSION = 2.11.1
PYTHON_CSSUTILS_SOURCE = cssutils-$(PYTHON_CSSUTILS_VERSION).tar.gz
PYTHON_CSSUTILS_SITE = https://files.pythonhosted.org/packages/33/9f/329d26121fe165be44b1dfff21aa0dc348f04633931f1d20ed6cf448a236
PYTHON_CSSUTILS_LICENSE = LGPL-3.0+
PYTHON_CSSUTILS_LICENSE_FILES = LICENSE
PYTHON_CSSUTILS_SETUP_TYPE = setuptools
PYTHON_CSSUTILS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

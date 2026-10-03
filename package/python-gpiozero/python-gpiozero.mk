################################################################################
#
# python-gpiozero
#
################################################################################

PYTHON_GPIOZERO_VERSION = 2.0.1.post3
PYTHON_GPIOZERO_SOURCE = gpiozero-$(PYTHON_GPIOZERO_VERSION).tar.gz
PYTHON_GPIOZERO_SITE = https://files.pythonhosted.org/packages/67/63/864a3c36842cf7b05808aadf906763a024a1b13f2a4c8144e3163de91255
PYTHON_GPIOZERO_LICENSE = BSD-3-Clause
PYTHON_GPIOZERO_LICENSE_FILES = LICENSE.rst
PYTHON_GPIOZERO_SETUP_TYPE = setuptools

$(eval $(python-package))

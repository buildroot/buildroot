################################################################################
#
# python-gpiozero
#
################################################################################

PYTHON_GPIOZERO_VERSION = 2.0.1
PYTHON_GPIOZERO_SOURCE = gpiozero-$(PYTHON_GPIOZERO_VERSION).tar.gz
PYTHON_GPIOZERO_SITE = https://files.pythonhosted.org/packages/e4/47/334b8db8a981eca9a0fb1e7e48e1997a5eaa8f40bb31c504299dcca0e6ff
PYTHON_GPIOZERO_LICENSE = BSD-3-Clause
PYTHON_GPIOZERO_LICENSE_FILES = LICENSE.rst
PYTHON_GPIOZERO_SETUP_TYPE = setuptools

$(eval $(python-package))

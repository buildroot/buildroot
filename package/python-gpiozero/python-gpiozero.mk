################################################################################
#
# python-gpiozero
#
################################################################################

PYTHON_GPIOZERO_VERSION = 2.0
PYTHON_GPIOZERO_SOURCE = gpiozero-$(PYTHON_GPIOZERO_VERSION).tar.gz
PYTHON_GPIOZERO_SITE = https://files.pythonhosted.org/packages/b3/a7/85676e0689114ea08ea3c88b7813efd988a9ead64dc9e1b24545b17af4fd
PYTHON_GPIOZERO_LICENSE = BSD-3-Clause
PYTHON_GPIOZERO_LICENSE_FILES = LICENSE.rst
PYTHON_GPIOZERO_SETUP_TYPE = setuptools

$(eval $(python-package))

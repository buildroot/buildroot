################################################################################
#
# python-pycairo
#
################################################################################

PYTHON_PYCAIRO_VERSION = 1.21.0
PYTHON_PYCAIRO_SOURCE = pycairo-$(PYTHON_PYCAIRO_VERSION).tar.gz
PYTHON_PYCAIRO_SITE = https://files.pythonhosted.org/packages/92/a4/506564f574fa74c90b98690e8ecc8dbae1629f31fcfe0be69de45d9e1605
PYTHON_PYCAIRO_SETUP_TYPE = setuptools
PYTHON_PYCAIRO_DEPENDENCIES = cairo
PYTHON_PYCAIRO_LICENSE = LGPL-2.1 or MPL-1.1
PYTHON_PYCAIRO_LICENSE_FILES = COPYING COPYING-LGPL-2.1 COPYING-MPL-1.1

$(eval $(python-package))

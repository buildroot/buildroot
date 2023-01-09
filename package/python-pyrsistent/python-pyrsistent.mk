################################################################################
#
# python-pyrsistent
#
################################################################################

PYTHON_PYRSISTENT_VERSION = 0.19.3
PYTHON_PYRSISTENT_SOURCE = pyrsistent-$(PYTHON_PYRSISTENT_VERSION).tar.gz
PYTHON_PYRSISTENT_SITE = https://files.pythonhosted.org/packages/bf/90/445a7dbd275c654c268f47fa9452152709134f61f09605cf776407055a89
PYTHON_PYRSISTENT_SETUP_TYPE = setuptools
PYTHON_PYRSISTENT_LICENSE = MIT
PYTHON_PYRSISTENT_LICENSE_FILES = LICENSE.mit

$(eval $(python-package))

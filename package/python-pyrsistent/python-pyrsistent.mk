################################################################################
#
# python-pyrsistent
#
################################################################################

PYTHON_PYRSISTENT_VERSION = 0.18.1
PYTHON_PYRSISTENT_SOURCE = pyrsistent-$(PYTHON_PYRSISTENT_VERSION).tar.gz
PYTHON_PYRSISTENT_SITE = https://files.pythonhosted.org/packages/42/ac/455fdc7294acc4d4154b904e80d964cc9aae75b087bbf486be04df9f2abd
PYTHON_PYRSISTENT_SETUP_TYPE = setuptools
PYTHON_PYRSISTENT_LICENSE = MIT
PYTHON_PYRSISTENT_LICENSE_FILES = LICENSE.mit

$(eval $(python-package))

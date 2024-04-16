################################################################################
#
# python-pyrsistent
#
################################################################################

PYTHON_PYRSISTENT_VERSION = 0.20.0
PYTHON_PYRSISTENT_SOURCE = pyrsistent-$(PYTHON_PYRSISTENT_VERSION).tar.gz
PYTHON_PYRSISTENT_SITE = https://files.pythonhosted.org/packages/ce/3a/5031723c09068e9c8c2f0bc25c3a9245f2b1d1aea8396c787a408f2b95ca
PYTHON_PYRSISTENT_SETUP_TYPE = setuptools
PYTHON_PYRSISTENT_LICENSE = MIT
PYTHON_PYRSISTENT_LICENSE_FILES = LICENSE.mit

$(eval $(python-package))

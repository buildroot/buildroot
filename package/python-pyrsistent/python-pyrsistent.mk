################################################################################
#
# python-pyrsistent
#
################################################################################

PYTHON_PYRSISTENT_VERSION = 0.19.2
PYTHON_PYRSISTENT_SOURCE = pyrsistent-$(PYTHON_PYRSISTENT_VERSION).tar.gz
PYTHON_PYRSISTENT_SITE = https://files.pythonhosted.org/packages/b8/ef/325da441a385a8a931b3eeb70db23cb52da42799691988d8d943c5237f10
PYTHON_PYRSISTENT_SETUP_TYPE = setuptools
PYTHON_PYRSISTENT_LICENSE = MIT
PYTHON_PYRSISTENT_LICENSE_FILES = LICENSE.mit

$(eval $(python-package))

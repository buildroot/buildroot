################################################################################
#
# python-kiwisolver
#
################################################################################

PYTHON_KIWISOLVER_VERSION = 1.4.7
PYTHON_KIWISOLVER_SOURCE = kiwisolver-$(PYTHON_KIWISOLVER_VERSION).tar.gz
PYTHON_KIWISOLVER_SITE = https://files.pythonhosted.org/packages/85/4d/2255e1c76304cbd60b48cee302b66d1dde4468dc5b1160e4b7cb43778f2a
PYTHON_KIWISOLVER_LICENSE = BSD-3-Clause
PYTHON_KIWISOLVER_LICENSE_FILES = LICENSE
PYTHON_KIWISOLVER_SETUP_TYPE = setuptools
PYTHON_KIWISOLVER_DEPENDENCIES = host-python-cppy

$(eval $(python-package))

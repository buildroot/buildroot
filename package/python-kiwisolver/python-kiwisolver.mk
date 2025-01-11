################################################################################
#
# python-kiwisolver
#
################################################################################

PYTHON_KIWISOLVER_VERSION = 1.4.8
PYTHON_KIWISOLVER_SOURCE = kiwisolver-$(PYTHON_KIWISOLVER_VERSION).tar.gz
PYTHON_KIWISOLVER_SITE = https://files.pythonhosted.org/packages/82/59/7c91426a8ac292e1cdd53a63b6d9439abd573c875c3f92c146767dd33faf
PYTHON_KIWISOLVER_LICENSE = BSD-3-Clause
PYTHON_KIWISOLVER_LICENSE_FILES = LICENSE
PYTHON_KIWISOLVER_SETUP_TYPE = setuptools
PYTHON_KIWISOLVER_DEPENDENCIES = host-python-cppy

$(eval $(python-package))

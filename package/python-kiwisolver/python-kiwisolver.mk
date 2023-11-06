################################################################################
#
# python-kiwisolver
#
################################################################################

PYTHON_KIWISOLVER_VERSION = 1.4.5
PYTHON_KIWISOLVER_SOURCE = kiwisolver-$(PYTHON_KIWISOLVER_VERSION).tar.gz
PYTHON_KIWISOLVER_SITE = https://files.pythonhosted.org/packages/b9/2d/226779e405724344fc678fcc025b812587617ea1a48b9442628b688e85ea
PYTHON_KIWISOLVER_LICENSE = BSD-3-Clause
PYTHON_KIWISOLVER_LICENSE_FILES = LICENSE
PYTHON_KIWISOLVER_SETUP_TYPE = setuptools
PYTHON_KIWISOLVER_DEPENDENCIES = host-python-cppy

$(eval $(python-package))

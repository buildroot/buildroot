################################################################################
#
# python-cppy
#
################################################################################

PYTHON_CPPY_VERSION = 1.3.1
PYTHON_CPPY_SOURCE = cppy-$(PYTHON_CPPY_VERSION).tar.gz
PYTHON_CPPY_SITE = https://files.pythonhosted.org/packages/45/ed/b35645a1b285bce356f30cc0fe77a042375c385660ccd61e0cdc4c1f7c44
PYTHON_CPPY_LICENSE = BSD-3-Clause
PYTHON_CPPY_LICENSE_FILES = LICENSE
PYTHON_CPPY_SETUP_TYPE = setuptools
HOST_PYTHON_CPPY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(host-python-package))

################################################################################
#
# python-cppy
#
################################################################################

PYTHON_CPPY_VERSION = 1.3.0
PYTHON_CPPY_SOURCE = cppy-$(PYTHON_CPPY_VERSION).tar.gz
PYTHON_CPPY_SITE = https://files.pythonhosted.org/packages/1e/84/62a09daa04e732a5763ec22dbc11b988e5140a77b418ea70bba9ab1a77a5
PYTHON_CPPY_LICENSE = BSD-3-Clause
PYTHON_CPPY_LICENSE_FILES = LICENSE
PYTHON_CPPY_SETUP_TYPE = setuptools
HOST_PYTHON_CPPY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(host-python-package))

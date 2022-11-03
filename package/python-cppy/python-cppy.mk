################################################################################
#
# python-cppy
#
################################################################################

PYTHON_CPPY_VERSION = 1.2.1
PYTHON_CPPY_SOURCE = cppy-$(PYTHON_CPPY_VERSION).tar.gz
PYTHON_CPPY_SITE = https://files.pythonhosted.org/packages/c5/7e/6cc5acd93752ee52d2f0423046072a2ce3ae16dfcd44373b9fe2a0222204
PYTHON_CPPY_LICENSE = BSD-3-Clause
PYTHON_CPPY_LICENSE_FILES = LICENSE
PYTHON_CPPY_SETUP_TYPE = setuptools

$(eval $(host-python-package))

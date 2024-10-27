################################################################################
#
# python-pysnmp
#
################################################################################

PYTHON_PYSNMP_VERSION = 7.1.8
PYTHON_PYSNMP_SOURCE = pysnmp-$(PYTHON_PYSNMP_VERSION).tar.gz
PYTHON_PYSNMP_SITE = https://files.pythonhosted.org/packages/e9/af/f9e379bd9e607fd289b6cef13d633667c4d213f8c1519a86f61eed09731f
PYTHON_PYSNMP_SETUP_TYPE = pep517
PYTHON_PYSNMP_LICENSE = BSD-2-Clause
PYTHON_PYSNMP_LICENSE_FILES = LICENSE.rst
PYTHON_PYSNMP_DEPENDENCIES = host-python-poetry-core

$(eval $(python-package))

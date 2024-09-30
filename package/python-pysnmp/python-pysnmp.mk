################################################################################
#
# python-pysnmp
#
################################################################################

PYTHON_PYSNMP_VERSION = 7.1.4
PYTHON_PYSNMP_SOURCE = pysnmp-$(PYTHON_PYSNMP_VERSION).tar.gz
PYTHON_PYSNMP_SITE = https://files.pythonhosted.org/packages/43/71/18a9d8c00efba166b66408040028f25a8ea20d2acc9cd89bd780369544b1
PYTHON_PYSNMP_SETUP_TYPE = pep517
PYTHON_PYSNMP_LICENSE = BSD-2-Clause
PYTHON_PYSNMP_LICENSE_FILES = LICENSE.rst
PYTHON_PYSNMP_DEPENDENCIES = host-python-poetry-core

$(eval $(python-package))

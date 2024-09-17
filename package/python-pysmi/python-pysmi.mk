################################################################################
#
# python-pysmi
#
################################################################################

PYTHON_PYSMI_VERSION = 1.5.0
PYTHON_PYSMI_SOURCE = pysmi-$(PYTHON_PYSMI_VERSION).tar.gz
PYTHON_PYSMI_SITE = https://files.pythonhosted.org/packages/59/d9/136ca19b66a917377a3b40f390f525eeeb21122dba7562a726bfb2d3629e
PYTHON_PYSMI_SETUP_TYPE = pep517
PYTHON_PYSMI_LICENSE = BSD-2-Clause
PYTHON_PYSMI_LICENSE_FILES = LICENSE.rst
PYTHON_PYSMI_DEPENDENCIES = host-python-poetry-core

$(eval $(python-package))

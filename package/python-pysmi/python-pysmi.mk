################################################################################
#
# python-pysmi
#
################################################################################

PYTHON_PYSMI_VERSION = 1.5.5
PYTHON_PYSMI_SOURCE = pysmi-$(PYTHON_PYSMI_VERSION).tar.gz
PYTHON_PYSMI_SITE = https://files.pythonhosted.org/packages/dc/fb/8461c21d0893c72492100b35fce128b057c4e615e79b0ce4496412ffec0c
PYTHON_PYSMI_SETUP_TYPE = pep517
PYTHON_PYSMI_LICENSE = BSD-2-Clause
PYTHON_PYSMI_LICENSE_FILES = LICENSE.rst
PYTHON_PYSMI_DEPENDENCIES = host-python-poetry-core

$(eval $(python-package))

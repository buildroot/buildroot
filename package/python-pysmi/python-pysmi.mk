################################################################################
#
# python-pysmi
#
################################################################################

PYTHON_PYSMI_VERSION = 2.0.0
PYTHON_PYSMI_SOURCE = pysmi-$(PYTHON_PYSMI_VERSION).tar.gz
PYTHON_PYSMI_SITE = https://files.pythonhosted.org/packages/ce/69/5666ed49ca34b418c3fdd9a6d7754566193ae0b9d2bc4b695ade7ef85b77
PYTHON_PYSMI_SETUP_TYPE = flit
PYTHON_PYSMI_LICENSE = BSD-2-Clause
PYTHON_PYSMI_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

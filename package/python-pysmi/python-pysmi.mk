################################################################################
#
# python-pysmi
#
################################################################################

PYTHON_PYSMI_VERSION = 1.6.2
PYTHON_PYSMI_SOURCE = pysmi-$(PYTHON_PYSMI_VERSION).tar.gz
PYTHON_PYSMI_SITE = https://files.pythonhosted.org/packages/a7/80/917111aaa4bf931bbd4d9a6c89864de2304b79cba8ce49639a6440ecd5ba
PYTHON_PYSMI_SETUP_TYPE = flit
PYTHON_PYSMI_LICENSE = BSD-2-Clause
PYTHON_PYSMI_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

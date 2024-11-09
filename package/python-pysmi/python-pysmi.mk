################################################################################
#
# python-pysmi
#
################################################################################

PYTHON_PYSMI_VERSION = 1.5.9
PYTHON_PYSMI_SOURCE = pysmi-$(PYTHON_PYSMI_VERSION).tar.gz
PYTHON_PYSMI_SITE = https://files.pythonhosted.org/packages/be/b0/19085322fc24f6b4a7bbc151643641c391b8b8d9aa4fd0e40d8178b2a5f5
PYTHON_PYSMI_SETUP_TYPE = poetry
PYTHON_PYSMI_LICENSE = BSD-2-Clause
PYTHON_PYSMI_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

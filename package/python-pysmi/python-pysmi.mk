################################################################################
#
# python-pysmi
#
################################################################################

PYTHON_PYSMI_VERSION = 1.5.6
PYTHON_PYSMI_SOURCE = pysmi-$(PYTHON_PYSMI_VERSION).tar.gz
PYTHON_PYSMI_SITE = https://files.pythonhosted.org/packages/a3/a1/b43edf8fd80c550782c9f0daa499c7d3013d31ff924405a7f96c9cdaa5d2
PYTHON_PYSMI_SETUP_TYPE = pep517
PYTHON_PYSMI_LICENSE = BSD-2-Clause
PYTHON_PYSMI_LICENSE_FILES = LICENSE.rst
PYTHON_PYSMI_DEPENDENCIES = host-python-poetry-core

$(eval $(python-package))

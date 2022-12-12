################################################################################
#
# python-pysnmp
#
################################################################################

PYTHON_PYSNMP_VERSION = 5.0.20
PYTHON_PYSNMP_SOURCE = pysnmplib-$(PYTHON_PYSNMP_VERSION).tar.gz
PYTHON_PYSNMP_SITE = https://files.pythonhosted.org/packages/68/a9/e5629fa7fcd53adf6333b535165c0352b7941d1ad89e79c78f083081bb0a
PYTHON_PYSNMP_SETUP_TYPE = setuptools
PYTHON_PYSNMP_LICENSE = BSD-3-Clause
PYTHON_PYSNMP_LICENSE_FILES = LICENSE.rst

PYTHON_PYSNMP_KEEP_PY_FILES += usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/pysnmp/smi/mibs/*.py
PYTHON_PYSNMP_KEEP_PY_FILES += usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/pysnmp/smi/mibs/instances/*.py

$(eval $(python-package))

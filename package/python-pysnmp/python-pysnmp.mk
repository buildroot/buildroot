################################################################################
#
# python-pysnmp
#
################################################################################

PYTHON_PYSNMP_VERSION = 4.4.12
PYTHON_PYSNMP_SOURCE = pysnmp-$(PYTHON_PYSNMP_VERSION).tar.gz
PYTHON_PYSNMP_SITE = https://files.pythonhosted.org/packages/4e/75/72f64c451bf5884715f84f8217b69b4025da0b67628d611cd14a5b7db217
PYTHON_PYSNMP_SETUP_TYPE = setuptools
PYTHON_PYSNMP_LICENSE = BSD-3-Clause
PYTHON_PYSNMP_LICENSE_FILES = LICENSE.rst

PYTHON_PYSNMP_KEEP_PY_FILES += usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/pysnmp/smi/mibs/*.py
PYTHON_PYSNMP_KEEP_PY_FILES += usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/pysnmp/smi/mibs/instances/*.py

$(eval $(python-package))

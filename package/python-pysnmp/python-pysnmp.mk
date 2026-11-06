################################################################################
#
# python-pysnmp
#
################################################################################

PYTHON_PYSNMP_VERSION = 7.1.31
PYTHON_PYSNMP_SOURCE = pysnmp-$(PYTHON_PYSNMP_VERSION).tar.gz
PYTHON_PYSNMP_SITE = https://files.pythonhosted.org/packages/8c/da/1fc15bc8255dbe8cb3effe46896e92a52db76c1ef53ab37c4e8ae9f09320
PYTHON_PYSNMP_SETUP_TYPE = flit
PYTHON_PYSNMP_LICENSE = BSD-2-Clause
PYTHON_PYSNMP_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

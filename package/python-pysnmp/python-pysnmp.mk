################################################################################
#
# python-pysnmp
#
################################################################################

PYTHON_PYSNMP_VERSION = 7.1.22
PYTHON_PYSNMP_SOURCE = pysnmp-$(PYTHON_PYSNMP_VERSION).tar.gz
PYTHON_PYSNMP_SITE = https://files.pythonhosted.org/packages/c5/f7/63a4833b675f3f85296d85f2fddaed93d76799f29a813a2d5ca2bbe7fc50
PYTHON_PYSNMP_SETUP_TYPE = flit
PYTHON_PYSNMP_LICENSE = BSD-2-Clause
PYTHON_PYSNMP_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

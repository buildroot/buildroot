################################################################################
#
# python-pysnmp
#
################################################################################

PYTHON_PYSNMP_VERSION = 7.1.13
PYTHON_PYSNMP_SOURCE = pysnmp-$(PYTHON_PYSNMP_VERSION).tar.gz
PYTHON_PYSNMP_SITE = https://files.pythonhosted.org/packages/d2/de/b766b1dc85e02c99835e05518d5efe9b2f1c875d406079584b4799d02db9
PYTHON_PYSNMP_SETUP_TYPE = poetry
PYTHON_PYSNMP_LICENSE = BSD-2-Clause
PYTHON_PYSNMP_LICENSE_FILES = LICENSE.rst

$(eval $(python-package))

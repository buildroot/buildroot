################################################################################
#
# python-mpmath
#
################################################################################

PYTHON_MPMATH_VERSION = 1.4.1
PYTHON_MPMATH_SOURCE = mpmath-$(PYTHON_MPMATH_VERSION).tar.gz
PYTHON_MPMATH_SITE = https://files.pythonhosted.org/packages/c5/b0/6de8e78014ff1842a90cc9a56da6ccfb598a5390ed0257fcdb7d9680c18b
PYTHON_MPMATH_SETUP_TYPE = setuptools
PYTHON_MPMATH_LICENSE = BSD-3-Clause
PYTHON_MPMATH_LICENSE_FILES = LICENSE
PYTHON_MPMATH_CPE_ID_VENDOR = mpmath
PYTHON_MPMATH_CPE_ID_PRODUCT = mpmath
PYTHON_MPMATH_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

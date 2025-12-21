################################################################################
#
# python-mpmath
#
################################################################################

PYTHON_MPMATH_VERSION = 1.3.0
PYTHON_MPMATH_SOURCE = mpmath-$(PYTHON_MPMATH_VERSION).tar.gz
PYTHON_MPMATH_SITE = https://files.pythonhosted.org/packages/e0/47/dd32fa426cc72114383ac549964eecb20ecfd886d1e5ccf5340b55b02f57
PYTHON_MPMATH_SETUP_TYPE = setuptools
PYTHON_MPMATH_LICENSE = BSD-3-Clause
PYTHON_MPMATH_LICENSE_FILES = LICENSE
PYTHON_MPMATH_CPE_ID_VENDOR = mpmath
PYTHON_MPMATH_CPE_ID_PRODUCT = mpmath

$(eval $(python-package))

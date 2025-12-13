################################################################################
#
# python-ml-dtypes
#
################################################################################

PYTHON_ML_DTYPES_VERSION = 0.5.4
PYTHON_ML_DTYPES_SOURCE = ml_dtypes-$(PYTHON_ML_DTYPES_VERSION).tar.gz
PYTHON_ML_DTYPES_SITE = https://files.pythonhosted.org/packages/0e/4a/c27b42ed9b1c7d13d9ba8b6905dece787d6259152f2309338aed29b2447b
PYTHON_ML_DTYPES_LICENSE = Apache-2.0
PYTHON_ML_DTYPES_LICENSE_FILES = LICENSE
PYTHON_ML_DTYPES_SETUP_TYPE = setuptools
PYTHON_ML_DTYPES_BUILD_OPTS = --skip-dependency-check

PYTHON_ML_DTYPES_DEPENDENCIES = \
	host-python-numpy \
	python-numpy

$(eval $(python-package))

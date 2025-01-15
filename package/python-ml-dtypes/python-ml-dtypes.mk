################################################################################
#
# python-ml-dtypes
#
################################################################################

PYTHON_ML_DTYPES_VERSION = 0.5.1
PYTHON_ML_DTYPES_SOURCE = ml_dtypes-$(PYTHON_ML_DTYPES_VERSION).tar.gz
PYTHON_ML_DTYPES_SITE = https://files.pythonhosted.org/packages/32/49/6e67c334872d2c114df3020e579f3718c333198f8312290e09ec0216703a
PYTHON_ML_DTYPES_LICENSE = Apache-2.0
PYTHON_ML_DTYPES_LICENSE_FILES = LICENSE
PYTHON_ML_DTYPES_SETUP_TYPE = setuptools
PYTHON_ML_DTYPES_BUILD_OPTS = --skip-dependency-check

PYTHON_ML_DTYPES_DEPENDENCIES = \
	host-python-numpy \
	python-numpy

$(eval $(python-package))

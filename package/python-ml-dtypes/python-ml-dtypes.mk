################################################################################
#
# python-ml-dtypes
#
################################################################################

PYTHON_ML_DTYPES_VERSION = 0.5.0
PYTHON_ML_DTYPES_SOURCE = ml_dtypes-$(PYTHON_ML_DTYPES_VERSION).tar.gz
PYTHON_ML_DTYPES_SITE = https://files.pythonhosted.org/packages/ab/79/717c5e22ad25d63ce3acdfe8ff8d64bdedec18914256c59b838218708b16
PYTHON_ML_DTYPES_LICENSE = Apache-2.0
PYTHON_ML_DTYPES_LICENSE_FILES = LICENSE
PYTHON_ML_DTYPES_SETUP_TYPE = setuptools
PYTHON_ML_DTYPES_BUILD_OPTS = --skip-dependency-check

PYTHON_ML_DTYPES_DEPENDENCIES = \
	host-python-numpy \
	python-numpy

$(eval $(python-package))

################################################################################
#
# python-ml-dtypes
#
################################################################################

PYTHON_ML_DTYPES_VERSION = 0.3.1
PYTHON_ML_DTYPES_SOURCE = ml_dtypes-$(PYTHON_ML_DTYPES_VERSION).tar.gz
PYTHON_ML_DTYPES_SITE = https://files.pythonhosted.org/packages/16/6e/9a7a51ee1ca24b8e92109128260c5aec8340c8fe5572e9ceecddae559abe
PYTHON_ML_DTYPES_LICENSE = Apache-2.0
PYTHON_ML_DTYPES_LICENSE_FILES = LICENSE
PYTHON_ML_DTYPES_SETUP_TYPE = distutils

PYTHON_ML_DTYPES_DEPENDENCIES = \
	host-python-numpy \
	python-numpy \
	python-pybind

$(eval $(python-package))

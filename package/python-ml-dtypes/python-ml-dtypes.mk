################################################################################
#
# python-ml-dtypes
#
################################################################################

PYTHON_ML_DTYPES_VERSION = 0.3.2
PYTHON_ML_DTYPES_SOURCE = ml_dtypes-$(PYTHON_ML_DTYPES_VERSION).tar.gz
PYTHON_ML_DTYPES_SITE = https://files.pythonhosted.org/packages/39/7d/8d85fcba868758b3a546e6914e727abd8f29ea6918079f816975c9eecd63
PYTHON_ML_DTYPES_LICENSE = Apache-2.0
PYTHON_ML_DTYPES_LICENSE_FILES = LICENSE
PYTHON_ML_DTYPES_SETUP_TYPE = setuptools

PYTHON_ML_DTYPES_DEPENDENCIES = \
	host-python-numpy \
	python-numpy

$(eval $(python-package))

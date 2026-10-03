################################################################################
#
# python-grpcio-reflection
#
################################################################################

PYTHON_GRPCIO_REFLECTION_VERSION = 1.84.0
PYTHON_GRPCIO_REFLECTION_SOURCE = grpcio_reflection-$(PYTHON_GRPCIO_REFLECTION_VERSION).tar.gz
PYTHON_GRPCIO_REFLECTION_SITE = https://files.pythonhosted.org/packages/6e/8a/94af17ae0738cc4508af96d5f107f352e2b54473eecf32f0ed9bcdd895da
PYTHON_GRPCIO_REFLECTION_SETUP_TYPE = setuptools
PYTHON_GRPCIO_REFLECTION_LICENSE = Apache-2.0
PYTHON_GRPCIO_REFLECTION_LICENSE_FILES = LICENSE

$(eval $(python-package))

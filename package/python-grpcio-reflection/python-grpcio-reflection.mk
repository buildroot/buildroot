################################################################################
#
# python-grpcio-reflection
#
################################################################################

PYTHON_GRPCIO_REFLECTION_VERSION = 1.70.0
PYTHON_GRPCIO_REFLECTION_SOURCE = grpcio_reflection-$(PYTHON_GRPCIO_REFLECTION_VERSION).tar.gz
PYTHON_GRPCIO_REFLECTION_SITE = https://files.pythonhosted.org/packages/42/98/f76681980ec7e9813e010d2778f4109816650760f6839661ae378286b3b5
PYTHON_GRPCIO_REFLECTION_SETUP_TYPE = setuptools
PYTHON_GRPCIO_REFLECTION_LICENSE = Apache-2.0
PYTHON_GRPCIO_REFLECTION_LICENSE_FILES = LICENSE

$(eval $(python-package))

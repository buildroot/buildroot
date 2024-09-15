################################################################################
#
# python-grpcio-reflection
#
################################################################################

PYTHON_GRPCIO_REFLECTION_VERSION = 1.66.1
PYTHON_GRPCIO_REFLECTION_SOURCE = grpcio_reflection-$(PYTHON_GRPCIO_REFLECTION_VERSION).tar.gz
PYTHON_GRPCIO_REFLECTION_SITE = https://files.pythonhosted.org/packages/f1/1c/8930a313a4cd60198921cedd4f6c2c88c282280780eb41995ddd980d6de9
PYTHON_GRPCIO_REFLECTION_SETUP_TYPE = setuptools
PYTHON_GRPCIO_REFLECTION_LICENSE = Apache-2.0
PYTHON_GRPCIO_REFLECTION_LICENSE_FILES = LICENSE

$(eval $(python-package))

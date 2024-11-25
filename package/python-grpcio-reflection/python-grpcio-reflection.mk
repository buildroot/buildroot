################################################################################
#
# python-grpcio-reflection
#
################################################################################

PYTHON_GRPCIO_REFLECTION_VERSION = 1.67.1
PYTHON_GRPCIO_REFLECTION_SOURCE = grpcio_reflection-$(PYTHON_GRPCIO_REFLECTION_VERSION).tar.gz
PYTHON_GRPCIO_REFLECTION_SITE = https://files.pythonhosted.org/packages/17/61/618d56bd1f7069dea5fee8fa6efb5e6548b6edb52000ef1a7b242c0c1b04
PYTHON_GRPCIO_REFLECTION_SETUP_TYPE = setuptools
PYTHON_GRPCIO_REFLECTION_LICENSE = Apache-2.0
PYTHON_GRPCIO_REFLECTION_LICENSE_FILES = LICENSE

$(eval $(python-package))

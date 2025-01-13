################################################################################
#
# python-grpcio
#
################################################################################

PYTHON_GRPCIO_VERSION = 1.69.0
PYTHON_GRPCIO_SOURCE = grpcio-$(PYTHON_GRPCIO_VERSION).tar.gz
PYTHON_GRPCIO_SITE = https://files.pythonhosted.org/packages/e4/87/06a145284cbe86c91ca517fe6b57be5efbb733c0d6374b407f0992054d18
PYTHON_GRPCIO_SETUP_TYPE = setuptools
PYTHON_GRPCIO_LICENSE = Apache-2.0
PYTHON_GRPCIO_LICENSE_FILES = LICENSE

$(eval $(python-package))

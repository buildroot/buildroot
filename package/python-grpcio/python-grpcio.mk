################################################################################
#
# python-grpcio
#
################################################################################

PYTHON_GRPCIO_VERSION = 1.84.1
PYTHON_GRPCIO_SOURCE = grpcio-$(PYTHON_GRPCIO_VERSION).tar.gz
PYTHON_GRPCIO_SITE = https://files.pythonhosted.org/packages/c0/3a/5c8e0eea2af3d30cb20d33ac325a98d9b799c069d63101ca4da20bcc776a
PYTHON_GRPCIO_SETUP_TYPE = setuptools
PYTHON_GRPCIO_LICENSE = Apache-2.0
PYTHON_GRPCIO_LICENSE_FILES = LICENSE
PYTHON_GRPCIO_BUILD_OPTS = --skip-dependency-check

$(eval $(python-package))

################################################################################
#
# python-grpcio
#
################################################################################

PYTHON_GRPCIO_VERSION = 1.66.1
PYTHON_GRPCIO_SOURCE = grpcio-$(PYTHON_GRPCIO_VERSION).tar.gz
PYTHON_GRPCIO_SITE = https://files.pythonhosted.org/packages/e7/42/94293200e40480d79fc876b2330e7dffb20f959b390afa77c0dbaa0c8372
PYTHON_GRPCIO_SETUP_TYPE = setuptools
PYTHON_GRPCIO_LICENSE = Apache-2.0
PYTHON_GRPCIO_LICENSE_FILES = LICENSE

$(eval $(python-package))

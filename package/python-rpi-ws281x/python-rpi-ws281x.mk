################################################################################
#
# python-rpi-ws281x
#
################################################################################

PYTHON_RPI_WS281X_VERSION = 5.0.0
PYTHON_RPI_WS281X_SOURCE = rpi_ws281x-$(PYTHON_RPI_WS281X_VERSION).tar.gz
PYTHON_RPI_WS281X_SITE = https://files.pythonhosted.org/packages/c0/1e/642208a685c5e96d38323f42c75d9b24f95e2d1b8390dd104e04a712f29e
PYTHON_RPI_WS281X_SETUP_TYPE = setuptools
PYTHON_RPI_WS281X_LICENSE = BSD-2-Clause
PYTHON_RPI_WS281X_LICENSE_FILES = LICENSE lib/LICENSE

$(eval $(python-package))

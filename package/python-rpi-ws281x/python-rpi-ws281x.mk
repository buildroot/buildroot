################################################################################
#
# python-rpi-ws281x
#
################################################################################

PYTHON_RPI_WS281X_VERSION = 4.2.6
PYTHON_RPI_WS281X_SOURCE = rpi_ws281x-$(PYTHON_RPI_WS281X_VERSION).tar.gz
PYTHON_RPI_WS281X_SITE = https://files.pythonhosted.org/packages/7f/1e/ea9ff56d9823fc55c79748630ffe0ceb30f619c9218743050bbf96d08704
PYTHON_RPI_WS281X_SETUP_TYPE = setuptools
PYTHON_RPI_WS281X_LICENSE = BSD-2-Clause
PYTHON_RPI_WS281X_LICENSE_FILES = LICENSE lib/LICENSE

$(eval $(python-package))

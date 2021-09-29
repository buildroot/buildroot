################################################################################
#
# python-rpi-ws281x
#
################################################################################

PYTHON_RPI_WS281X_VERSION = 4.3.0
PYTHON_RPI_WS281X_SOURCE = rpi_ws281x-$(PYTHON_RPI_WS281X_VERSION).tar.gz
PYTHON_RPI_WS281X_SITE = https://files.pythonhosted.org/packages/cd/b3/eb7ac93376952f165577707ec756f40c9537ed53c59fcbc3290c357370e0
PYTHON_RPI_WS281X_SETUP_TYPE = setuptools
PYTHON_RPI_WS281X_LICENSE = BSD-2-Clause
PYTHON_RPI_WS281X_LICENSE_FILES = LICENSE lib/LICENSE

$(eval $(python-package))

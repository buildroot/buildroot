################################################################################
#
# python-serial-asyncio
#
################################################################################

PYTHON_SERIAL_ASYNCIO_VERSION = 0.6
PYTHON_SERIAL_ASYNCIO_SOURCE = pyserial-asyncio-$(PYTHON_SERIAL_ASYNCIO_VERSION).tar.gz
PYTHON_SERIAL_ASYNCIO_SITE = https://files.pythonhosted.org/packages/4a/9a/8477699dcbc1882ea51dcff4d3c25aa3f2063ed8f7d7a849fd8f610506b6
PYTHON_SERIAL_ASYNCIO_LICENSE = BSD-3-Clause
PYTHON_SERIAL_ASYNCIO_LICENSE_FILES = LICENSE.txt
PYTHON_SERIAL_ASYNCIO_SETUP_TYPE = setuptools

$(eval $(python-package))

################################################################################
#
# python-opcua-asyncio
#
################################################################################

PYTHON_OPCUA_ASYNCIO_VERSION = 2.0.1
PYTHON_OPCUA_ASYNCIO_SOURCE = asyncua-$(PYTHON_OPCUA_ASYNCIO_VERSION).tar.gz
PYTHON_OPCUA_ASYNCIO_SITE = https://files.pythonhosted.org/packages/d9/7d/14830444700e18631853c417b05472c7036cd266e90866e8d0ae4bcd7c72
PYTHON_OPCUA_ASYNCIO_SETUP_TYPE = hatch
PYTHON_OPCUA_ASYNCIO_LICENSE = LGPL-3.0+
PYTHON_OPCUA_ASYNCIO_LICENSE_FILES = COPYING
PYTHON_OPCUA_ASYNCIO_CPE_ID_VENDOR = freeopcua
PYTHON_OPCUA_ASYNCIO_CPE_ID_PRODUCT = opcua-asyncio

$(eval $(python-package))

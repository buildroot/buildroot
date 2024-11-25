################################################################################
#
# python-opcua-asyncio
#
################################################################################

PYTHON_OPCUA_ASYNCIO_VERSION = 1.1.5
PYTHON_OPCUA_ASYNCIO_SOURCE = asyncua-$(PYTHON_OPCUA_ASYNCIO_VERSION).tar.gz
PYTHON_OPCUA_ASYNCIO_SITE = https://files.pythonhosted.org/packages/49/be/be6dad2b7db58fc9e92260fa9fdda8604841f2863d60ec2c49dccb1f9661
PYTHON_OPCUA_ASYNCIO_SETUP_TYPE = setuptools
PYTHON_OPCUA_ASYNCIO_LICENSE = LGPL-3.0+
PYTHON_OPCUA_ASYNCIO_LICENSE_FILES = COPYING
PYTHON_OPCUA_ASYNCIO_CPE_ID_VENDOR = freeopcua
PYTHON_OPCUA_ASYNCIO_CPE_ID_PRODUCT = opcua-asyncio

$(eval $(python-package))

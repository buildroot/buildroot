################################################################################
#
# python-opcua-asyncio
#
################################################################################

PYTHON_OPCUA_ASYNCIO_VERSION = 2.1.0
PYTHON_OPCUA_ASYNCIO_SOURCE = asyncua-$(PYTHON_OPCUA_ASYNCIO_VERSION).tar.gz
PYTHON_OPCUA_ASYNCIO_SITE = https://files.pythonhosted.org/packages/c6/90/13c47fa62aa83f2ed98a931aa3a7bcc77a3e7163400eb9f2d9e1d3c9df07
PYTHON_OPCUA_ASYNCIO_SETUP_TYPE = hatch
PYTHON_OPCUA_ASYNCIO_LICENSE = LGPL-3.0+
PYTHON_OPCUA_ASYNCIO_LICENSE_FILES = COPYING
PYTHON_OPCUA_ASYNCIO_CPE_ID_VENDOR = freeopcua
PYTHON_OPCUA_ASYNCIO_CPE_ID_PRODUCT = opcua-asyncio

$(eval $(python-package))

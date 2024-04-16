################################################################################
#
# python-opcua-asyncio
#
################################################################################

PYTHON_OPCUA_ASYNCIO_VERSION = 1.0.5
PYTHON_OPCUA_ASYNCIO_SOURCE = asyncua-$(PYTHON_OPCUA_ASYNCIO_VERSION).tar.gz
PYTHON_OPCUA_ASYNCIO_SITE = https://files.pythonhosted.org/packages/bf/c6/3c17b8b5335faffc2f08c728008c5ae7cc46d24f674bc1038a69d1849ef6
PYTHON_OPCUA_ASYNCIO_SETUP_TYPE = setuptools
PYTHON_OPCUA_ASYNCIO_LICENSE = LGPL-3.0+
PYTHON_OPCUA_ASYNCIO_LICENSE_FILES = COPYING
PYTHON_OPCUA_ASYNCIO_CPE_ID_VENDOR = freeopcua
PYTHON_OPCUA_ASYNCIO_CPE_ID_PRODUCT = opcua-asyncio

$(eval $(python-package))

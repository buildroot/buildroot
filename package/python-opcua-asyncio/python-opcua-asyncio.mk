################################################################################
#
# python-opcua-asyncio
#
################################################################################

PYTHON_OPCUA_ASYNCIO_VERSION = 1.0.0
PYTHON_OPCUA_ASYNCIO_SOURCE = asyncua-$(PYTHON_OPCUA_ASYNCIO_VERSION).tar.gz
PYTHON_OPCUA_ASYNCIO_SITE = https://files.pythonhosted.org/packages/e7/ea/6fe0799c740b0fc8ffda42fc97bf45204ffe06fe41d505c02654e0d4e379
PYTHON_OPCUA_ASYNCIO_SETUP_TYPE = setuptools
PYTHON_OPCUA_ASYNCIO_LICENSE = LGPL-3.0+
PYTHON_OPCUA_ASYNCIO_LICENSE_FILES = COPYING

$(eval $(python-package))

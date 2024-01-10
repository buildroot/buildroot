################################################################################
#
# python-aiohttp-sse-client
#
################################################################################

PYTHON_AIOHTTP_SSE_CLIENT_VERSION = 0.2.1
PYTHON_AIOHTTP_SSE_CLIENT_SOURCE = aiohttp-sse-client-$(PYTHON_AIOHTTP_SSE_CLIENT_VERSION).tar.gz
PYTHON_AIOHTTP_SSE_CLIENT_SITE = https://files.pythonhosted.org/packages/71/c3/4825c5f37909a70c8018924b3d521847dd7acf1fce7e1054574bafed2271
PYTHON_AIOHTTP_SSE_CLIENT_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_SSE_CLIENT_LICENSE = Apache-2.0
PYTHON_AIOHTTP_SSE_CLIENT_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-aiohttp-sse
#
################################################################################

PYTHON_AIOHTTP_SSE_VERSION = 3.0
PYTHON_AIOHTTP_SSE_SOURCE = aiohttp_sse-$(PYTHON_AIOHTTP_SSE_VERSION).tar.gz
PYTHON_AIOHTTP_SSE_SITE = https://files.pythonhosted.org/packages/af/6d/01d7f71e38ac91a912dd8c4ed1a1481316dc83cb6c42043bbfa1b647c0e4
PYTHON_AIOHTTP_SSE_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_SSE_LICENSE = Apache-2.0
PYTHON_AIOHTTP_SSE_LICENSE_FILES = LICENSE

$(eval $(python-package))

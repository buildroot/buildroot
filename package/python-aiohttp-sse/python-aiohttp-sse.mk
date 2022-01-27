################################################################################
#
# python-aiohttp-sse
#
################################################################################

PYTHON_AIOHTTP_SSE_VERSION = 2.1.0
PYTHON_AIOHTTP_SSE_SOURCE = aiohttp-sse-$(PYTHON_AIOHTTP_SSE_VERSION).tar.gz
PYTHON_AIOHTTP_SSE_SITE = https://files.pythonhosted.org/packages/2f/3f/cc4f5a3fe6cb50ad5b9d26bb7738c5da1f61645b517d4230df2fc32d89f0
PYTHON_AIOHTTP_SSE_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_SSE_LICENSE = Apache-2.0
PYTHON_AIOHTTP_SSE_LICENSE_FILES = LICENSE

$(eval $(python-package))

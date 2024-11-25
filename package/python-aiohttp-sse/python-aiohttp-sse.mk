################################################################################
#
# python-aiohttp-sse
#
################################################################################

PYTHON_AIOHTTP_SSE_VERSION = 2.2.0
PYTHON_AIOHTTP_SSE_SOURCE = aiohttp-sse-$(PYTHON_AIOHTTP_SSE_VERSION).tar.gz
PYTHON_AIOHTTP_SSE_SITE = https://files.pythonhosted.org/packages/80/df/4ddb30e689695fd91cf41c072e154061120ed166e8baf6c9a0020f27dffc
PYTHON_AIOHTTP_SSE_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_SSE_LICENSE = Apache-2.0
PYTHON_AIOHTTP_SSE_LICENSE_FILES = LICENSE

$(eval $(python-package))

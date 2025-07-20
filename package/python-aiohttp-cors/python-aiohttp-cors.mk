################################################################################
#
# python-aiohttp-cors
#
################################################################################

PYTHON_AIOHTTP_CORS_VERSION = 0.8.1
PYTHON_AIOHTTP_CORS_SOURCE = aiohttp_cors-$(PYTHON_AIOHTTP_CORS_VERSION).tar.gz
PYTHON_AIOHTTP_CORS_SITE = https://files.pythonhosted.org/packages/6f/6d/d89e846a5444b3d5eb8985a6ddb0daef3774928e1bfbce8e84ec97b0ffa7
PYTHON_AIOHTTP_CORS_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_CORS_LICENSE = Apache-2.0
PYTHON_AIOHTTP_CORS_LICENSE_FILES = LICENSE

$(eval $(python-package))

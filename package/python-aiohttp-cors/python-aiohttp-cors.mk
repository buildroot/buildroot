################################################################################
#
# python-aiohttp-cors
#
################################################################################

PYTHON_AIOHTTP_CORS_VERSION = 0.8.0
PYTHON_AIOHTTP_CORS_SOURCE = aiohttp_cors-$(PYTHON_AIOHTTP_CORS_VERSION).tar.gz
PYTHON_AIOHTTP_CORS_SITE = https://files.pythonhosted.org/packages/1d/a8/3edbba1d565f7888c52e04ac6188e19b812a9fc39d81dea413f3abf81bfa
PYTHON_AIOHTTP_CORS_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_CORS_LICENSE = Apache-2.0
PYTHON_AIOHTTP_CORS_LICENSE_FILES = LICENSE

$(eval $(python-package))

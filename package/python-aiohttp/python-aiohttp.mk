################################################################################
#
# python-aiohttp
#
################################################################################

PYTHON_AIOHTTP_VERSION = 3.11.12
PYTHON_AIOHTTP_SOURCE = aiohttp-$(PYTHON_AIOHTTP_VERSION).tar.gz
PYTHON_AIOHTTP_SITE = https://files.pythonhosted.org/packages/37/4b/952d49c73084fb790cb5c6ead50848c8e96b4980ad806cf4d2ad341eaa03
PYTHON_AIOHTTP_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_LICENSE = Apache-2.0
PYTHON_AIOHTTP_LICENSE_FILES = LICENSE.txt
PYTHON_AIOHTTP_CPE_ID_VENDOR = aiohttp
PYTHON_AIOHTTP_CPE_ID_PRODUCT = aiohttp

$(eval $(python-package))

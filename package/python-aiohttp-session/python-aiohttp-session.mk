################################################################################
#
# python-aiohttp-session
#
################################################################################

PYTHON_AIOHTTP_SESSION_VERSION = 2.10.0
PYTHON_AIOHTTP_SESSION_SOURCE = aiohttp-session-$(PYTHON_AIOHTTP_SESSION_VERSION).tar.gz
PYTHON_AIOHTTP_SESSION_SITE = https://files.pythonhosted.org/packages/d6/3f/ab6288e8bbf4a9ae63ea0d3d5711bccc3a6dad1cb85a420c14fdeabc209e
PYTHON_AIOHTTP_SESSION_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_SESSION_LICENSE = Apache-2.0
PYTHON_AIOHTTP_SESSION_LICENSE_FILES = LICENSE
PYTHON_AIOHTTP_SESSION_CPE_ID_VENDOR = aiohttp-session_project
PYTHON_AIOHTTP_SESSION_CPE_ID_PRODUCT = aiohttp-session

$(eval $(python-package))

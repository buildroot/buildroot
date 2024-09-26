################################################################################
#
# python-aiohttp-session
#
################################################################################

PYTHON_AIOHTTP_SESSION_VERSION = 2.12.1
PYTHON_AIOHTTP_SESSION_SOURCE = aiohttp_session-$(PYTHON_AIOHTTP_SESSION_VERSION).tar.gz
PYTHON_AIOHTTP_SESSION_SITE = https://files.pythonhosted.org/packages/c2/c4/d73a7f19b1bd3149ba5bccd22e3ab580c19e4d9fcb83114309e8385ab807
PYTHON_AIOHTTP_SESSION_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_SESSION_LICENSE = Apache-2.0
PYTHON_AIOHTTP_SESSION_LICENSE_FILES = LICENSE
PYTHON_AIOHTTP_SESSION_CPE_ID_VENDOR = aiohttp-session_project
PYTHON_AIOHTTP_SESSION_CPE_ID_PRODUCT = aiohttp-session

$(eval $(python-package))

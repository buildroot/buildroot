################################################################################
#
# python-aiohttp-session
#
################################################################################

PYTHON_AIOHTTP_SESSION_VERSION = 2.11.0
PYTHON_AIOHTTP_SESSION_SOURCE = aiohttp-session-$(PYTHON_AIOHTTP_SESSION_VERSION).tar.gz
PYTHON_AIOHTTP_SESSION_SITE = https://files.pythonhosted.org/packages/3b/a7/0b97b9a2e3a553a86a6703f86b0e9b1afb2b262849700e8f80015c0f643f
PYTHON_AIOHTTP_SESSION_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_SESSION_LICENSE = Apache-2.0
PYTHON_AIOHTTP_SESSION_LICENSE_FILES = LICENSE
PYTHON_AIOHTTP_SESSION_CPE_ID_VENDOR = aiohttp-session_project
PYTHON_AIOHTTP_SESSION_CPE_ID_PRODUCT = aiohttp-session

$(eval $(python-package))

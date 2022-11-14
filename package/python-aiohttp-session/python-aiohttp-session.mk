################################################################################
#
# python-aiohttp-session
#
################################################################################

PYTHON_AIOHTTP_SESSION_VERSION = 2.12.0
PYTHON_AIOHTTP_SESSION_SOURCE = aiohttp-session-$(PYTHON_AIOHTTP_SESSION_VERSION).tar.gz
PYTHON_AIOHTTP_SESSION_SITE = https://files.pythonhosted.org/packages/34/87/8dbc1385c875497d6bc16c9d94e25dbd8ff62599843b73fb4048ba74c867
PYTHON_AIOHTTP_SESSION_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_SESSION_LICENSE = Apache-2.0
PYTHON_AIOHTTP_SESSION_LICENSE_FILES = LICENSE
PYTHON_AIOHTTP_SESSION_CPE_ID_VENDOR = aiohttp-session_project
PYTHON_AIOHTTP_SESSION_CPE_ID_PRODUCT = aiohttp-session

$(eval $(python-package))

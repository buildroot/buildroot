################################################################################
#
# python-aiohttp-security
#
################################################################################

PYTHON_AIOHTTP_SECURITY_VERSION = 0.5.0
PYTHON_AIOHTTP_SECURITY_SOURCE = aiohttp-security-$(PYTHON_AIOHTTP_SECURITY_VERSION).tar.gz
PYTHON_AIOHTTP_SECURITY_SITE = https://files.pythonhosted.org/packages/31/49/56c131fe3dead875ab5907b154dac7fb6ee727662de80b7da0ff045030d4
PYTHON_AIOHTTP_SECURITY_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_SECURITY_LICENSE = Apache-2.0
PYTHON_AIOHTTP_SECURITY_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-aiohttp-remotes
#
################################################################################

PYTHON_AIOHTTP_REMOTES_VERSION = 1.2.0
PYTHON_AIOHTTP_REMOTES_SOURCE = aiohttp_remotes-$(PYTHON_AIOHTTP_REMOTES_VERSION).tar.gz
PYTHON_AIOHTTP_REMOTES_SITE = https://files.pythonhosted.org/packages/54/05/7c4be6171cc78a13171a4f89e5d308c4a636bdd8ee36101367e99e410ed8
PYTHON_AIOHTTP_REMOTES_SETUP_TYPE = flit
PYTHON_AIOHTTP_REMOTES_LICENSE = MIT
PYTHON_AIOHTTP_REMOTES_LICENSE_FILES = LICENSE

$(eval $(python-package))

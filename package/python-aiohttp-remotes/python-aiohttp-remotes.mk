################################################################################
#
# python-aiohttp-remotes
#
################################################################################

PYTHON_AIOHTTP_REMOTES_VERSION = 1.3.0
PYTHON_AIOHTTP_REMOTES_SOURCE = aiohttp_remotes-$(PYTHON_AIOHTTP_REMOTES_VERSION).tar.gz
PYTHON_AIOHTTP_REMOTES_SITE = https://files.pythonhosted.org/packages/7e/bd/b59c3f8858c3b333b067e2432db95400f1423d7ee6eadfbf4e99a3a30fa3
PYTHON_AIOHTTP_REMOTES_SETUP_TYPE = flit
PYTHON_AIOHTTP_REMOTES_LICENSE = MIT
PYTHON_AIOHTTP_REMOTES_LICENSE_FILES = LICENSE

$(eval $(python-package))

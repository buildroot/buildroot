################################################################################
#
# python-aiohttp-remotes
#
################################################################################

PYTHON_AIOHTTP_REMOTES_VERSION = 1.1.0
PYTHON_AIOHTTP_REMOTES_SOURCE = aiohttp_remotes-$(PYTHON_AIOHTTP_REMOTES_VERSION).tar.gz
PYTHON_AIOHTTP_REMOTES_SITE = https://files.pythonhosted.org/packages/e3/fc/5523010172e2d8685a8934fbb49d564118c9ebc1e4233a62b77310f979db
PYTHON_AIOHTTP_REMOTES_SETUP_TYPE = distutils
PYTHON_AIOHTTP_REMOTES_LICENSE = MIT
PYTHON_AIOHTTP_REMOTES_LICENSE_FILES = LICENSE

$(eval $(python-package))

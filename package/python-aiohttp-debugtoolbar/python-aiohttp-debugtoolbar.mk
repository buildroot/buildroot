################################################################################
#
# python-aiohttp-debugtoolbar
#
################################################################################

PYTHON_AIOHTTP_DEBUGTOOLBAR_VERSION = 0.6.1
PYTHON_AIOHTTP_DEBUGTOOLBAR_SOURCE = aiohttp-debugtoolbar-$(PYTHON_AIOHTTP_DEBUGTOOLBAR_VERSION).tar.gz
PYTHON_AIOHTTP_DEBUGTOOLBAR_SITE = https://files.pythonhosted.org/packages/bd/72/cd80c0d1d425d5ef50e5b23553040e8d9fa5de5714208d3d18ae8806b6de
PYTHON_AIOHTTP_DEBUGTOOLBAR_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_DEBUGTOOLBAR_LICENSE = Apache-2.0
PYTHON_AIOHTTP_DEBUGTOOLBAR_LICENSE_FILES = LICENSE

$(eval $(python-package))

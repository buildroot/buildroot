################################################################################
#
# python-aiohttp-jinja2
#
################################################################################

PYTHON_AIOHTTP_JINJA2_VERSION = 1.5.1
PYTHON_AIOHTTP_JINJA2_SOURCE = aiohttp-jinja2-$(PYTHON_AIOHTTP_JINJA2_VERSION).tar.gz
PYTHON_AIOHTTP_JINJA2_SITE = https://files.pythonhosted.org/packages/4e/4c/fadbfcc1269fa79e69fcdb29027840ab022a91471a5aeaa8fd8b27cc5406
PYTHON_AIOHTTP_JINJA2_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_JINJA2_LICENSE = Apache-2.0
PYTHON_AIOHTTP_JINJA2_LICENSE_FILES = LICENSE

$(eval $(python-package))

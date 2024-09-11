################################################################################
#
# python-aiohttp-jinja2
#
################################################################################

PYTHON_AIOHTTP_JINJA2_VERSION = 1.6
PYTHON_AIOHTTP_JINJA2_SOURCE = aiohttp-jinja2-$(PYTHON_AIOHTTP_JINJA2_VERSION).tar.gz
PYTHON_AIOHTTP_JINJA2_SITE = https://files.pythonhosted.org/packages/e6/39/da5a94dd89b1af7241fb7fc99ae4e73505b5f898b540b6aba6dc7afe600e
PYTHON_AIOHTTP_JINJA2_SETUP_TYPE = setuptools
PYTHON_AIOHTTP_JINJA2_LICENSE = Apache-2.0
PYTHON_AIOHTTP_JINJA2_LICENSE_FILES = LICENSE

$(eval $(python-package))

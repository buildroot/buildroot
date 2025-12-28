################################################################################
#
# python-aiosqlite
#
################################################################################

PYTHON_AIOSQLITE_VERSION = 0.22.1
PYTHON_AIOSQLITE_SOURCE = aiosqlite-$(PYTHON_AIOSQLITE_VERSION).tar.gz
PYTHON_AIOSQLITE_SITE = https://files.pythonhosted.org/packages/4e/8a/64761f4005f17809769d23e518d915db74e6310474e733e3593cfc854ef1
PYTHON_AIOSQLITE_SETUP_TYPE = flit
PYTHON_AIOSQLITE_LICENSE = MIT
PYTHON_AIOSQLITE_LICENSE_FILES = LICENSE

$(eval $(python-package))

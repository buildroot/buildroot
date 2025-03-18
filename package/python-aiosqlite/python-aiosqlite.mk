################################################################################
#
# python-aiosqlite
#
################################################################################

PYTHON_AIOSQLITE_VERSION = 0.21.0
PYTHON_AIOSQLITE_SOURCE = aiosqlite-$(PYTHON_AIOSQLITE_VERSION).tar.gz
PYTHON_AIOSQLITE_SITE = https://files.pythonhosted.org/packages/13/7d/8bca2bf9a247c2c5dfeec1d7a5f40db6518f88d314b8bca9da29670d2671
PYTHON_AIOSQLITE_SETUP_TYPE = flit
PYTHON_AIOSQLITE_LICENSE = MIT
PYTHON_AIOSQLITE_LICENSE_FILES = LICENSE

$(eval $(python-package))

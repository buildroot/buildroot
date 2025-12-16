################################################################################
#
# python-aiosqlite
#
################################################################################

PYTHON_AIOSQLITE_VERSION = 0.22.0
PYTHON_AIOSQLITE_SOURCE = aiosqlite-$(PYTHON_AIOSQLITE_VERSION).tar.gz
PYTHON_AIOSQLITE_SITE = https://files.pythonhosted.org/packages/3a/0d/449c024bdabd0678ae07d804e60ed3b9786facd3add66f51eee67a0fccea
PYTHON_AIOSQLITE_SETUP_TYPE = flit
PYTHON_AIOSQLITE_LICENSE = MIT
PYTHON_AIOSQLITE_LICENSE_FILES = LICENSE

$(eval $(python-package))

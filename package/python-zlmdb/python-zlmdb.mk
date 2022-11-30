################################################################################
#
# python-zlmdb
#
################################################################################

PYTHON_ZLMDB_VERSION = 22.3.1
PYTHON_ZLMDB_SOURCE = zlmdb-$(PYTHON_ZLMDB_VERSION).tar.gz
PYTHON_ZLMDB_SITE = https://files.pythonhosted.org/packages/71/87/bb3cebd5312e670e33551317c7fc5e4b6a4a9af39075a71cd541b32cc0bf
PYTHON_ZLMDB_SETUP_TYPE = setuptools
PYTHON_ZLMDB_LICENSE = MIT
PYTHON_ZLMDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

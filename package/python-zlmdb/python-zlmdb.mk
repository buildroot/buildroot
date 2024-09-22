################################################################################
#
# python-zlmdb
#
################################################################################

PYTHON_ZLMDB_VERSION = 23.1.1
PYTHON_ZLMDB_SOURCE = zlmdb-$(PYTHON_ZLMDB_VERSION).tar.gz
PYTHON_ZLMDB_SITE = https://files.pythonhosted.org/packages/56/b2/abaeb5419435a6224a0beb2b5edad621ec975fe4802297963ecf1728b883
PYTHON_ZLMDB_SETUP_TYPE = setuptools
PYTHON_ZLMDB_LICENSE = MIT
PYTHON_ZLMDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

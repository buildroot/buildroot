################################################################################
#
# python-lmdb
#
################################################################################

PYTHON_LMDB_VERSION = 1.2.1
PYTHON_LMDB_SOURCE = lmdb-$(PYTHON_LMDB_VERSION).tar.gz
PYTHON_LMDB_SITE = https://files.pythonhosted.org/packages/2f/df/3aea5279753cb8ab0c96dec43106e24f388d4179d5224f6d3e652016c095
PYTHON_LMDB_LICENSE = OLDAP-2.8
PYTHON_LMDB_LICENSE_FILES = LICENSE
PYTHON_LMDB_SETUP_TYPE = setuptools
PYTHON_LMDB_DEPENDENCIES = host-python-cffi

$(eval $(python-package))

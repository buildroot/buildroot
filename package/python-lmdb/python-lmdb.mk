################################################################################
#
# python-lmdb
#
################################################################################

PYTHON_LMDB_VERSION = 1.3.0
PYTHON_LMDB_SOURCE = lmdb-$(PYTHON_LMDB_VERSION).tar.gz
PYTHON_LMDB_SITE = https://files.pythonhosted.org/packages/ed/61/41f3c7cbd8a67202ef24fad3375ed936093a0547dc645581dd11c09581b7
PYTHON_LMDB_LICENSE = OLDAP-2.8
PYTHON_LMDB_LICENSE_FILES = LICENSE
PYTHON_LMDB_SETUP_TYPE = setuptools
PYTHON_LMDB_DEPENDENCIES = host-python-cffi

$(eval $(python-package))

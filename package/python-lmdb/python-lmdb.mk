################################################################################
#
# python-lmdb
#
################################################################################

PYTHON_LMDB_VERSION = 1.4.0
PYTHON_LMDB_SOURCE = lmdb-$(PYTHON_LMDB_VERSION).tar.gz
PYTHON_LMDB_SITE = https://files.pythonhosted.org/packages/fd/78/4cdc5927d5f3c3c86c4da0108c2eeba544cd67e773232164d59f3e442ff0
PYTHON_LMDB_LICENSE = OLDAP-2.8
PYTHON_LMDB_LICENSE_FILES = LICENSE
PYTHON_LMDB_SETUP_TYPE = setuptools
PYTHON_LMDB_DEPENDENCIES = host-python-cffi

$(eval $(python-package))

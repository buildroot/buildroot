################################################################################
#
# python-zlmdb
#
################################################################################

PYTHON_ZLMDB_VERSION = 22.6.1
PYTHON_ZLMDB_SOURCE = zlmdb-$(PYTHON_ZLMDB_VERSION).tar.gz
PYTHON_ZLMDB_SITE = https://files.pythonhosted.org/packages/97/15/992e61a18cb64b573814c9d92676b22d522f2cc2ea79ff78b834bd392b80
PYTHON_ZLMDB_SETUP_TYPE = setuptools
PYTHON_ZLMDB_LICENSE = MIT
PYTHON_ZLMDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

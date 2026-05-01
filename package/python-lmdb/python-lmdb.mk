################################################################################
#
# python-lmdb
#
################################################################################

PYTHON_LMDB_VERSION = 2.2.0
PYTHON_LMDB_SOURCE = lmdb-$(PYTHON_LMDB_VERSION).tar.gz
PYTHON_LMDB_SITE = https://files.pythonhosted.org/packages/21/44/d94934efaf8f887b6959f131fde740fcaa831edfd13eb5425574637cddd5
PYTHON_LMDB_LICENSE = OLDAP-2.8
PYTHON_LMDB_LICENSE_FILES = LICENSE
PYTHON_LMDB_DEPENDENCIES = host-python-cffi host-python-patch-ng
PYTHON_LMDB_CPE_ID_VENDOR = py-lmdb_project
PYTHON_LMDB_CPE_ID_PRODUCT = py-lmdb
PYTHON_LMDB_SETUP_TYPE = setuptools

$(eval $(python-package))

################################################################################
#
# python-lmdb
#
################################################################################

PYTHON_LMDB_VERSION = 1.8.1
PYTHON_LMDB_SOURCE = lmdb-$(PYTHON_LMDB_VERSION).tar.gz
PYTHON_LMDB_SITE = https://files.pythonhosted.org/packages/23/19/392f028e7ebcc1cc8212fe8a315a909b7a556278456f0bab9234d3a3b665
PYTHON_LMDB_LICENSE = OLDAP-2.8
PYTHON_LMDB_LICENSE_FILES = LICENSE
PYTHON_LMDB_DEPENDENCIES = host-python-cffi host-python-patch-ng
PYTHON_LMDB_CPE_ID_VENDOR = py-lmdb_project
PYTHON_LMDB_CPE_ID_PRODUCT = py-lmdb
PYTHON_LMDB_SETUP_TYPE = setuptools

$(eval $(python-package))

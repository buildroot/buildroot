################################################################################
#
# python-lmdb
#
################################################################################

PYTHON_LMDB_VERSION = 2.3.0
PYTHON_LMDB_SOURCE = lmdb-$(PYTHON_LMDB_VERSION).tar.gz
PYTHON_LMDB_SITE = https://files.pythonhosted.org/packages/aa/0b/17f271b2d2d314da9c9bc7620676ede1feca5f565f3a46045319351f7bc2
PYTHON_LMDB_LICENSE = OLDAP-2.8
PYTHON_LMDB_LICENSE_FILES = LICENSE
PYTHON_LMDB_DEPENDENCIES = host-python-cffi host-python-patch-ng
PYTHON_LMDB_CPE_ID_VENDOR = py-lmdb_project
PYTHON_LMDB_CPE_ID_PRODUCT = py-lmdb
PYTHON_LMDB_SETUP_TYPE = setuptools

$(eval $(python-package))

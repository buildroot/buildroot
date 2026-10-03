################################################################################
#
# python-lmdb
#
################################################################################

PYTHON_LMDB_VERSION = 3.0.0
PYTHON_LMDB_SOURCE = lmdb-$(PYTHON_LMDB_VERSION).tar.gz
PYTHON_LMDB_SITE = https://files.pythonhosted.org/packages/1f/80/24a4064047b1c98ac73c0ad806f16bcd2d800c2eb460d6e6c2961034b8a1
PYTHON_LMDB_LICENSE = OLDAP-2.8
PYTHON_LMDB_LICENSE_FILES = LICENSE
PYTHON_LMDB_DEPENDENCIES = host-python-cffi host-python-patch-ng
PYTHON_LMDB_CPE_ID_VENDOR = py-lmdb_project
PYTHON_LMDB_CPE_ID_PRODUCT = py-lmdb
PYTHON_LMDB_SETUP_TYPE = setuptools

$(eval $(python-package))

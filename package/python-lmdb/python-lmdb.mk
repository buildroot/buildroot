################################################################################
#
# python-lmdb
#
################################################################################

PYTHON_LMDB_VERSION = 1.5.1
PYTHON_LMDB_SOURCE = lmdb-$(PYTHON_LMDB_VERSION).tar.gz
PYTHON_LMDB_SITE = https://files.pythonhosted.org/packages/67/2c/0cc9375341121ca1f4b31a2137f955dc24550e095d733c9b42ea94113ba1
PYTHON_LMDB_LICENSE = OLDAP-2.8
PYTHON_LMDB_LICENSE_FILES = LICENSE
PYTHON_LMDB_CPE_ID_VENDOR = py-lmdb_project
PYTHON_LMDB_CPE_ID_PRODUCT = py-lmdb
PYTHON_LMDB_SETUP_TYPE = setuptools

$(eval $(python-package))

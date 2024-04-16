################################################################################
#
# python-lmdb
#
################################################################################

PYTHON_LMDB_VERSION = 1.4.1
PYTHON_LMDB_SOURCE = lmdb-$(PYTHON_LMDB_VERSION).tar.gz
PYTHON_LMDB_SITE = https://files.pythonhosted.org/packages/de/13/dd9b0c1924f0becc93e0bacd123a4e7a347966e3e74753ace3b1e85acc39
PYTHON_LMDB_LICENSE = OLDAP-2.8
PYTHON_LMDB_LICENSE_FILES = LICENSE
PYTHON_LMDB_CPE_ID_VENDOR = py-lmdb_project
PYTHON_LMDB_CPE_ID_PRODUCT = py-lmdb
PYTHON_LMDB_SETUP_TYPE = setuptools
PYTHON_LMDB_DEPENDENCIES = host-python-cffi

$(eval $(python-package))

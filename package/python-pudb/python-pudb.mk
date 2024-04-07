################################################################################
#
# python-pudb
#
################################################################################

PYTHON_PUDB_VERSION = 2024.1
PYTHON_PUDB_SOURCE = pudb-$(PYTHON_PUDB_VERSION).tar.gz
PYTHON_PUDB_SITE = https://files.pythonhosted.org/packages/b3/a1/db467e7c828e2ced173d9dbb47abc17ca0e0b3225cb1f4066293e63a2ed9
PYTHON_PUDB_SETUP_TYPE = setuptools
PYTHON_PUDB_LICENSE = MIT
PYTHON_PUDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

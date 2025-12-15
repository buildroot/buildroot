################################################################################
#
# python-pudb
#
################################################################################

PYTHON_PUDB_VERSION = 2025.1.5
PYTHON_PUDB_SOURCE = pudb-$(PYTHON_PUDB_VERSION).tar.gz
PYTHON_PUDB_SITE = https://files.pythonhosted.org/packages/f5/69/0c52c6058da586e173e48ef8f9c45bc805d9df78d5ad4d69467ff68694b5
PYTHON_PUDB_SETUP_TYPE = hatch
PYTHON_PUDB_LICENSE = MIT
PYTHON_PUDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

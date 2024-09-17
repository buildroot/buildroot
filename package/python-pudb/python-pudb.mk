################################################################################
#
# python-pudb
#
################################################################################

PYTHON_PUDB_VERSION = 2024.1.2
PYTHON_PUDB_SOURCE = pudb-$(PYTHON_PUDB_VERSION).tar.gz
PYTHON_PUDB_SITE = https://files.pythonhosted.org/packages/54/70/fc7d81b7ac439d5e21c8c2b51e15cdc6632b720b02219057fe098a80e766
PYTHON_PUDB_SETUP_TYPE = setuptools
PYTHON_PUDB_LICENSE = MIT
PYTHON_PUDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

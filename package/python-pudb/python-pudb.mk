################################################################################
#
# python-pudb
#
################################################################################

PYTHON_PUDB_VERSION = 2022.1.2
PYTHON_PUDB_SOURCE = pudb-$(PYTHON_PUDB_VERSION).tar.gz
PYTHON_PUDB_SITE = https://files.pythonhosted.org/packages/8b/ef/6dea7c63fdddd7753e2a2930e59799ef32247f2499c0d9bcd233439e7483
PYTHON_PUDB_SETUP_TYPE = setuptools
PYTHON_PUDB_LICENSE = MIT
PYTHON_PUDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

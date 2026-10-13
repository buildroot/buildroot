################################################################################
#
# python-pudb
#
################################################################################

PYTHON_PUDB_VERSION = 2026.1
PYTHON_PUDB_SOURCE = pudb-$(PYTHON_PUDB_VERSION).tar.gz
PYTHON_PUDB_SITE = https://files.pythonhosted.org/packages/0e/ed/9fed39a03222995a65ce2e1ebc90b9dc27dc099bcd05613a61a0967e0877
PYTHON_PUDB_SETUP_TYPE = hatch
PYTHON_PUDB_LICENSE = MIT
PYTHON_PUDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-simplesqlite
#
################################################################################

PYTHON_SIMPLESQLITE_VERSION = 1.5.2
PYTHON_SIMPLESQLITE_SOURCE = SimpleSQLite-$(PYTHON_SIMPLESQLITE_VERSION).tar.gz
PYTHON_SIMPLESQLITE_SITE = https://files.pythonhosted.org/packages/c8/07/92e3291fda6f1bbf6e7ff4721d87566e1615572d9c205ef64398c5d22efe
PYTHON_SIMPLESQLITE_SETUP_TYPE = setuptools
PYTHON_SIMPLESQLITE_LICENSE = MIT
PYTHON_SIMPLESQLITE_LICENSE_FILES = LICENSE

$(eval $(python-package))

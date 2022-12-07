################################################################################
#
# python-simplesqlite
#
################################################################################

PYTHON_SIMPLESQLITE_VERSION = 1.3.0
PYTHON_SIMPLESQLITE_SOURCE = SimpleSQLite-$(PYTHON_SIMPLESQLITE_VERSION).tar.gz
PYTHON_SIMPLESQLITE_SITE = https://files.pythonhosted.org/packages/a0/2c/39a9e7dc4af46d101f48753086c686982790ecc2bdf5e9fa88f85f027e7a
PYTHON_SIMPLESQLITE_SETUP_TYPE = setuptools
PYTHON_SIMPLESQLITE_LICENSE = MIT
PYTHON_SIMPLESQLITE_LICENSE_FILES = LICENSE

$(eval $(python-package))

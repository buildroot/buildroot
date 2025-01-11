################################################################################
#
# python-simplesqlite
#
################################################################################

PYTHON_SIMPLESQLITE_VERSION = 1.5.3
PYTHON_SIMPLESQLITE_SOURCE = simplesqlite-$(PYTHON_SIMPLESQLITE_VERSION).tar.gz
PYTHON_SIMPLESQLITE_SITE = https://files.pythonhosted.org/packages/59/a8/c8f4af95618dda725d91a081476036656fbf3660bb6f1728d1a5d088d6cc
PYTHON_SIMPLESQLITE_SETUP_TYPE = setuptools
PYTHON_SIMPLESQLITE_LICENSE = MIT
PYTHON_SIMPLESQLITE_LICENSE_FILES = LICENSE

$(eval $(python-package))

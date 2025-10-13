################################################################################
#
# python-simplesqlite
#
################################################################################

PYTHON_SIMPLESQLITE_VERSION = 1.5.4
PYTHON_SIMPLESQLITE_SOURCE = simplesqlite-$(PYTHON_SIMPLESQLITE_VERSION).tar.gz
PYTHON_SIMPLESQLITE_SITE = https://files.pythonhosted.org/packages/1a/73/94ee1a1711ca04c7269f2d32472d10ad8cdc85ebf32c42e1cfc6924d39d8
PYTHON_SIMPLESQLITE_SETUP_TYPE = setuptools
PYTHON_SIMPLESQLITE_LICENSE = MIT
PYTHON_SIMPLESQLITE_LICENSE_FILES = LICENSE

$(eval $(python-package))

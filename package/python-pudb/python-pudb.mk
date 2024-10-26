################################################################################
#
# python-pudb
#
################################################################################

PYTHON_PUDB_VERSION = 2024.1.3
PYTHON_PUDB_SOURCE = pudb-$(PYTHON_PUDB_VERSION).tar.gz
PYTHON_PUDB_SITE = https://files.pythonhosted.org/packages/36/27/fb087bdf2cd9c8e56d0347b863ce5995967c15a3e2a0b9245c7a8f6f1598
PYTHON_PUDB_SETUP_TYPE = hatch
PYTHON_PUDB_LICENSE = MIT
PYTHON_PUDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

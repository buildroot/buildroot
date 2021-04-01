################################################################################
#
# python-pudb
#
################################################################################

PYTHON_PUDB_VERSION = 2020.1
PYTHON_PUDB_SOURCE = pudb-$(PYTHON_PUDB_VERSION).tar.gz
PYTHON_PUDB_SITE = https://files.pythonhosted.org/packages/3d/bc/1947dc9dc54a44bc6cbff3556cd514258886a4a60e85aa32a3ba027098bc
PYTHON_PUDB_SETUP_TYPE = setuptools
PYTHON_PUDB_LICENSE = MIT
PYTHON_PUDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

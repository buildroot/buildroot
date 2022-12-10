################################################################################
#
# python-pudb
#
################################################################################

PYTHON_PUDB_VERSION = 2022.1.3
PYTHON_PUDB_SOURCE = pudb-$(PYTHON_PUDB_VERSION).tar.gz
PYTHON_PUDB_SITE = https://files.pythonhosted.org/packages/85/a5/f1fd378f56bd8168b5921fd09d4b84fd8101a90e81402a509796caea2094
PYTHON_PUDB_SETUP_TYPE = setuptools
PYTHON_PUDB_LICENSE = MIT
PYTHON_PUDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

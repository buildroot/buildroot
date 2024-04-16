################################################################################
#
# python-ipdb
#
################################################################################

PYTHON_IPDB_VERSION = 0.13.13
PYTHON_IPDB_SOURCE = ipdb-$(PYTHON_IPDB_VERSION).tar.gz
PYTHON_IPDB_SITE = https://files.pythonhosted.org/packages/3d/1b/7e07e7b752017f7693a0f4d41c13e5ca29ce8cbcfdcc1fd6c4ad8c0a27a0
PYTHON_IPDB_SETUP_TYPE = setuptools
PYTHON_IPDB_LICENSE = BSD-3-Clause
PYTHON_IPDB_LICENSE_FILES = COPYING.txt

$(eval $(python-package))

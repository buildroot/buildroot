################################################################################
#
# python-pudb
#
################################################################################

PYTHON_PUDB_VERSION = 2018.1
PYTHON_PUDB_SOURCE = pudb-$(PYTHON_PUDB_VERSION).tar.gz
PYTHON_PUDB_SITE = https://files.pythonhosted.org/packages/d1/e9/d27fb1a5f00c722247b8003c9a81240e49c01dfa6f7fb510d19355a48679
PYTHON_PUDB_SETUP_TYPE = setuptools
PYTHON_PUDB_LICENSE = MIT
PYTHON_PUDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

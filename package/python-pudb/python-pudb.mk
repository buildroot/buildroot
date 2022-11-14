################################################################################
#
# python-pudb
#
################################################################################

PYTHON_PUDB_VERSION = 2021.1
PYTHON_PUDB_SOURCE = pudb-$(PYTHON_PUDB_VERSION).tar.gz
PYTHON_PUDB_SITE = https://files.pythonhosted.org/packages/c7/69/813e93519fc28744457ff68fa2eaac3b4ea30dda1e6994e969fe9d3008d9
PYTHON_PUDB_SETUP_TYPE = setuptools
PYTHON_PUDB_LICENSE = MIT
PYTHON_PUDB_LICENSE_FILES = LICENSE

$(eval $(python-package))

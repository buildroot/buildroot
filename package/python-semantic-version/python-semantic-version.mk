################################################################################
#
# python-semantic-version
#
################################################################################

PYTHON_SEMANTIC_VERSION_VERSION = 2.10.0
PYTHON_SEMANTIC_VERSION_SOURCE = semantic_version-$(PYTHON_SEMANTIC_VERSION_VERSION).tar.gz
PYTHON_SEMANTIC_VERSION_SITE = https://files.pythonhosted.org/packages/7d/31/f2289ce78b9b473d582568c234e104d2a342fd658cc288a7553d83bb8595
PYTHON_SEMANTIC_VERSION_SETUP_TYPE = setuptools
PYTHON_SEMANTIC_VERSION_LICENSE = BSD-2-Clause
PYTHON_SEMANTIC_VERSION_LICENSE_FILES = LICENSE

$(eval $(host-python-package))

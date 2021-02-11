################################################################################
#
# python-semantic-version
#
################################################################################

PYTHON_SEMANTIC_VERSION_VERSION = 2.8.5
PYTHON_SEMANTIC_VERSION_SOURCE = semantic_version-$(PYTHON_SEMANTIC_VERSION_VERSION).tar.gz
PYTHON_SEMANTIC_VERSION_SITE = https://files.pythonhosted.org/packages/d4/52/3be868c7ed1f408cb822bc92ce17ffe4e97d11c42caafce0589f05844dd0
PYTHON_SEMANTIC_VERSION_SETUP_TYPE = setuptools
PYTHON_SEMANTIC_VERSION_LICENSE = BSD-2-Clause
PYTHON_SEMANTIC_VERSION_LICENSE_FILES = LICENSE

$(eval $(host-python-package))

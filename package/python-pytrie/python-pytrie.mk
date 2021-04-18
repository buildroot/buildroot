################################################################################
#
# python-pytrie
#
################################################################################

PYTHON_PYTRIE_VERSION = 0.4.0
PYTHON_PYTRIE_SOURCE = PyTrie-$(PYTHON_PYTRIE_VERSION).tar.gz
PYTHON_PYTRIE_LICENSE = BSD-3-Clause
PYTHON_PYTRIE_LICENSE_FILES = LICENSE
PYTHON_PYTRIE_SITE = https://files.pythonhosted.org/packages/d3/19/15ec77ab9c85f7c36eb590d6ab7dd529f8c8516c0e2219f1a77a99d7ee77
PYTHON_PYTRIE_SETUP_TYPE = setuptools

$(eval $(python-package))

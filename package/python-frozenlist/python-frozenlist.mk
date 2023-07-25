################################################################################
#
# python-frozenlist
#
################################################################################

PYTHON_FROZENLIST_VERSION = 1.4.0
PYTHON_FROZENLIST_SOURCE = frozenlist-$(PYTHON_FROZENLIST_VERSION).tar.gz
PYTHON_FROZENLIST_SITE = https://files.pythonhosted.org/packages/8c/1f/49c96ccc87127682ba900b092863ef7c20302a2144b3185412a08480ca22
PYTHON_FROZENLIST_SETUP_TYPE = setuptools
PYTHON_FROZENLIST_LICENSE = Apache-2.0
PYTHON_FROZENLIST_LICENSE_FILES = LICENSE

$(eval $(python-package))

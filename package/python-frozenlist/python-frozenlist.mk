################################################################################
#
# python-frozenlist
#
################################################################################

PYTHON_FROZENLIST_VERSION = 1.3.0
PYTHON_FROZENLIST_SOURCE = frozenlist-$(PYTHON_FROZENLIST_VERSION).tar.gz
PYTHON_FROZENLIST_SITE = https://files.pythonhosted.org/packages/f4/f7/8dfeb76d2a52bcea2b0718427af954ffec98be1d34cd8f282034b3e36829
PYTHON_FROZENLIST_SETUP_TYPE = setuptools
PYTHON_FROZENLIST_LICENSE = Apache-2.0
PYTHON_FROZENLIST_LICENSE_FILES = LICENSE

$(eval $(python-package))

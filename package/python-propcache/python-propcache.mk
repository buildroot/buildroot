################################################################################
#
# python-propcache
#
################################################################################

PYTHON_PROPCACHE_VERSION = 0.3.2
PYTHON_PROPCACHE_SOURCE = propcache-$(PYTHON_PROPCACHE_VERSION).tar.gz
PYTHON_PROPCACHE_SITE = https://files.pythonhosted.org/packages/a6/16/43264e4a779dd8588c21a70f0709665ee8f611211bdd2c87d952cfa7c776
PYTHON_PROPCACHE_SETUP_TYPE = setuptools
PYTHON_PROPCACHE_LICENSE = Apache-2.0
PYTHON_PROPCACHE_LICENSE_FILES = LICENSE
PYTHON_PROPCACHE_DEPENDENCIES = \
	host-python-cython \
	host-python-expandvars

$(eval $(python-package))

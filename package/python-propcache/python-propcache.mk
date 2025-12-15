################################################################################
#
# python-propcache
#
################################################################################

PYTHON_PROPCACHE_VERSION = 0.4.1
PYTHON_PROPCACHE_SOURCE = propcache-$(PYTHON_PROPCACHE_VERSION).tar.gz
PYTHON_PROPCACHE_SITE = https://files.pythonhosted.org/packages/9e/da/e9fc233cf63743258bff22b3dfa7ea5baef7b5bc324af47a0ad89b8ffc6f
PYTHON_PROPCACHE_SETUP_TYPE = setuptools
PYTHON_PROPCACHE_LICENSE = Apache-2.0
PYTHON_PROPCACHE_LICENSE_FILES = LICENSE
PYTHON_PROPCACHE_DEPENDENCIES = \
	host-python-cython \
	host-python-expandvars

$(eval $(python-package))

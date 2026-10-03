################################################################################
#
# python-propcache
#
################################################################################

PYTHON_PROPCACHE_VERSION = 0.5.4
PYTHON_PROPCACHE_SOURCE = propcache-$(PYTHON_PROPCACHE_VERSION).tar.gz
PYTHON_PROPCACHE_SITE = https://files.pythonhosted.org/packages/b3/9a/9fbf4e4ec0c2d7f1c32519fff782ef467859b8faa9fbc5331a96f6395d43
PYTHON_PROPCACHE_SETUP_TYPE = setuptools
PYTHON_PROPCACHE_LICENSE = Apache-2.0
PYTHON_PROPCACHE_LICENSE_FILES = LICENSE
PYTHON_PROPCACHE_BUILD_OPTS = --skip-dependency-check
PYTHON_PROPCACHE_DEPENDENCIES = \
	host-python-cython \
	host-python-expandvars

$(eval $(python-package))

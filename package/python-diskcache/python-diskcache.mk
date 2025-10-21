################################################################################
#
# python-diskcache
#
################################################################################

PYTHON_DISKCACHE_VERSION = 5.6.3
PYTHON_DISKCACHE_SOURCE = diskcache-$(PYTHON_DISKCACHE_VERSION).tar.gz
PYTHON_DISKCACHE_SITE = https://files.pythonhosted.org/packages/3f/21/1c1ffc1a039ddcc459db43cc108658f32c57d271d7289a2794e401d0fdb6
PYTHON_DISKCACHE_SETUP_TYPE = setuptools
PYTHON_DISKCACHE_LICENSE = Apache-2.0
PYTHON_DISKCACHE_LICENSE_FILES = LICENSE

# diskcache imports itself during the build to get its own version,
# which doesn't work in the Buildroot context, so we inject the
# package name and version manually.
define PYTHON_DISKCACHE_REMOVE_SELF_IMPORT
	sed -i -e '/import diskcache/d' \
		-e 's/diskcache.__title__/"diskcache"/' \
		-e 's/diskcache.__version__/"$(PYTHON_DISKCACHE_VERSION)"/' \
		$(@D)/setup.py
endef

PYTHON_DISKCACHE_POST_PATCH_HOOKS += PYTHON_DISKCACHE_REMOVE_SELF_IMPORT

$(eval $(python-package))

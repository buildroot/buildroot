################################################################################
#
# python-pymemcache
#
################################################################################

PYTHON_PYMEMCACHE_VERSION = 3.5.2
PYTHON_PYMEMCACHE_SOURCE = pymemcache-$(PYTHON_PYMEMCACHE_VERSION).tar.gz
PYTHON_PYMEMCACHE_SITE = https://github.com/pinterest/pymemcache/releases/download/v$(PYTHON_PYMEMCACHE_VERSION)
PYTHON_PYMEMCACHE_LICENSE = Apache-2.0
PYTHON_PYMEMCACHE_LICENSE_FILES = LICENSE.txt
PYTHON_PYMEMCACHE_SETUP_TYPE = pep517
PYTHON_PYMEMCACHE_DEPENDENCIES = python-six

$(eval $(python-package))

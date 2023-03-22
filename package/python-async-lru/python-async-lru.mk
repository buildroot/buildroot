################################################################################
#
# python-async-lru
#
################################################################################

PYTHON_ASYNC_LRU_VERSION = 2.0.2
PYTHON_ASYNC_LRU_SOURCE = async-lru-$(PYTHON_ASYNC_LRU_VERSION).tar.gz
PYTHON_ASYNC_LRU_SITE = https://files.pythonhosted.org/packages/92/16/be197573adca3d584dbd64d508488e95e36324ea036d751564d2f88d74bf
PYTHON_ASYNC_LRU_SETUP_TYPE = setuptools
PYTHON_ASYNC_LRU_LICENSE = MIT
PYTHON_ASYNC_LRU_LICENSE_FILES = LICENSE

$(eval $(python-package))

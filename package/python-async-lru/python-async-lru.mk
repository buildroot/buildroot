################################################################################
#
# python-async-lru
#
################################################################################

PYTHON_ASYNC_LRU_VERSION = 2.2.0
PYTHON_ASYNC_LRU_SOURCE = async_lru-$(PYTHON_ASYNC_LRU_VERSION).tar.gz
PYTHON_ASYNC_LRU_SITE = https://files.pythonhosted.org/packages/05/8a/ca724066c32a53fa75f59e0f21aa822fdaa8a0dffa112d223634e3caabf9
PYTHON_ASYNC_LRU_SETUP_TYPE = setuptools
PYTHON_ASYNC_LRU_LICENSE = MIT
PYTHON_ASYNC_LRU_LICENSE_FILES = LICENSE

$(eval $(python-package))

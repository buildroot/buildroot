################################################################################
#
# python-async-lru
#
################################################################################

PYTHON_ASYNC_LRU_VERSION = 1.0.3
PYTHON_ASYNC_LRU_SOURCE = async-lru-$(PYTHON_ASYNC_LRU_VERSION).tar.gz
PYTHON_ASYNC_LRU_SITE = https://files.pythonhosted.org/packages/fe/67/4cb179c14ffa8b4a35fbe02255744bee4cbbaf61b35612c96ba4a618e4d5
PYTHON_ASYNC_LRU_SETUP_TYPE = setuptools
PYTHON_ASYNC_LRU_LICENSE = MIT
PYTHON_ASYNC_LRU_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-async-lru
#
################################################################################

PYTHON_ASYNC_LRU_VERSION = 2.0.5
PYTHON_ASYNC_LRU_SOURCE = async_lru-$(PYTHON_ASYNC_LRU_VERSION).tar.gz
PYTHON_ASYNC_LRU_SITE = https://files.pythonhosted.org/packages/b2/4d/71ec4d3939dc755264f680f6c2b4906423a304c3d18e96853f0a595dfe97
PYTHON_ASYNC_LRU_SETUP_TYPE = setuptools
PYTHON_ASYNC_LRU_LICENSE = MIT
PYTHON_ASYNC_LRU_LICENSE_FILES = LICENSE

$(eval $(python-package))

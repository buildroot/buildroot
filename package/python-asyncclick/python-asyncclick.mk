################################################################################
#
# python-asyncclick
#
################################################################################

PYTHON_ASYNCCLICK_VERSION = 8.1.8
PYTHON_ASYNCCLICK_SOURCE = asyncclick-$(PYTHON_ASYNCCLICK_VERSION).tar.gz
PYTHON_ASYNCCLICK_SITE = https://files.pythonhosted.org/packages/cb/b5/e1e5fdf1c1bb7e6e614987c120a98d9324bf8edfaa5f5cd16a6235c9d91b
PYTHON_ASYNCCLICK_SETUP_TYPE = flit
PYTHON_ASYNCCLICK_LICENSE = BSD-3-Clause
PYTHON_ASYNCCLICK_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

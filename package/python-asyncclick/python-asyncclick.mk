################################################################################
#
# python-asyncclick
#
################################################################################

PYTHON_ASYNCCLICK_VERSION = 8.2.2.2
PYTHON_ASYNCCLICK_SOURCE = asyncclick-$(PYTHON_ASYNCCLICK_VERSION).tar.gz
PYTHON_ASYNCCLICK_SITE = https://files.pythonhosted.org/packages/35/51/b01dd77c9a14fb0b312d799fd8c10b145b882535dbaa9ac055a52515b390
PYTHON_ASYNCCLICK_SETUP_TYPE = flit
PYTHON_ASYNCCLICK_LICENSE = BSD-3-Clause
PYTHON_ASYNCCLICK_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

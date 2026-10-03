################################################################################
#
# python-asyncclick
#
################################################################################

PYTHON_ASYNCCLICK_VERSION = 8.4.2.1
PYTHON_ASYNCCLICK_SOURCE = asyncclick-$(PYTHON_ASYNCCLICK_VERSION).tar.gz
PYTHON_ASYNCCLICK_SITE = https://files.pythonhosted.org/packages/fd/b2/2c90a32d9b9cf1a4a90ed39cc1177890d146f3f89ae375b061d72110659a
PYTHON_ASYNCCLICK_SETUP_TYPE = flit
PYTHON_ASYNCCLICK_LICENSE = BSD-3-Clause
PYTHON_ASYNCCLICK_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

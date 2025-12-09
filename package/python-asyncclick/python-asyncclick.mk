################################################################################
#
# python-asyncclick
#
################################################################################

PYTHON_ASYNCCLICK_VERSION = 8.3.0.7
PYTHON_ASYNCCLICK_SOURCE = asyncclick-$(PYTHON_ASYNCCLICK_VERSION).tar.gz
PYTHON_ASYNCCLICK_SITE = https://files.pythonhosted.org/packages/f9/ca/25e426d16bd0e91c1c9259112cecd17b2c2c239bdd8e5dba430f3bd5e3ef
PYTHON_ASYNCCLICK_SETUP_TYPE = flit
PYTHON_ASYNCCLICK_LICENSE = BSD-3-Clause
PYTHON_ASYNCCLICK_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

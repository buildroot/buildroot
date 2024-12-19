################################################################################
#
# python-asyncclick
#
################################################################################

PYTHON_ASYNCCLICK_VERSION = 8.1.7.2
PYTHON_ASYNCCLICK_SOURCE = asyncclick-$(PYTHON_ASYNCCLICK_VERSION).tar.gz
PYTHON_ASYNCCLICK_SITE = https://files.pythonhosted.org/packages/5e/bf/59d836c3433d7aa07f76c2b95c4eb763195ea8a5d7f9ad3311ed30c2af61
PYTHON_ASYNCCLICK_SETUP_TYPE = setuptools
PYTHON_ASYNCCLICK_LICENSE = BSD-3-Clause
PYTHON_ASYNCCLICK_LICENSE_FILES = LICENSE.rst
PYTHON_ASYNCCLICK_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

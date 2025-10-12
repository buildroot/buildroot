################################################################################
#
# python-decorator
#
################################################################################

PYTHON_DECORATOR_VERSION = 5.2.1
PYTHON_DECORATOR_SOURCE = decorator-$(PYTHON_DECORATOR_VERSION).tar.gz
PYTHON_DECORATOR_SITE = https://files.pythonhosted.org/packages/43/fa/6d96a0978d19e17b68d634497769987b16c8f4cd0a7a05048bec693caa6b
PYTHON_DECORATOR_LICENSE = BSD-2-Clause
PYTHON_DECORATOR_LICENSE_FILES = LICENSE.txt
PYTHON_DECORATOR_CPE_ID_VENDOR = python
PYTHON_DECORATOR_CPE_ID_PRODUCT = decorator
PYTHON_DECORATOR_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))

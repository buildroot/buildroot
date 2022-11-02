################################################################################
#
# python-decorator
#
################################################################################

PYTHON_DECORATOR_VERSION = 5.1.1
PYTHON_DECORATOR_SOURCE = decorator-$(PYTHON_DECORATOR_VERSION).tar.gz
PYTHON_DECORATOR_SITE = https://files.pythonhosted.org/packages/66/0c/8d907af351aa16b42caae42f9d6aa37b900c67308052d10fdce809f8d952
PYTHON_DECORATOR_LICENSE = BSD-2-Clause
PYTHON_DECORATOR_LICENSE_FILES = LICENSE.txt
PYTHON_DECORATOR_CPE_ID_VENDOR = python
PYTHON_DECORATOR_CPE_ID_PRODUCT = decorator
PYTHON_DECORATOR_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))

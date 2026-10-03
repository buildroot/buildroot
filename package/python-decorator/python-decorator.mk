################################################################################
#
# python-decorator
#
################################################################################

PYTHON_DECORATOR_VERSION = 5.3.1
PYTHON_DECORATOR_SOURCE = decorator-$(PYTHON_DECORATOR_VERSION).tar.gz
PYTHON_DECORATOR_SITE = https://files.pythonhosted.org/packages/60/8b/32f9823da46cde7df2087faa08cd98d01b908f8dcab982cdba9c84e85355
PYTHON_DECORATOR_LICENSE = BSD-2-Clause
PYTHON_DECORATOR_LICENSE_FILES = LICENSE.txt
PYTHON_DECORATOR_CPE_ID_VENDOR = python
PYTHON_DECORATOR_CPE_ID_PRODUCT = decorator
PYTHON_DECORATOR_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))

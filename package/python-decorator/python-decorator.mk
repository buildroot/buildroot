################################################################################
#
# python-decorator
#
################################################################################

PYTHON_DECORATOR_VERSION = 5.1.0
PYTHON_DECORATOR_SOURCE = decorator-$(PYTHON_DECORATOR_VERSION).tar.gz
PYTHON_DECORATOR_SITE = https://files.pythonhosted.org/packages/92/3c/34f8448b61809968052882b830f7d8d9a8e1c07048f70deb039ae599f73c
PYTHON_DECORATOR_LICENSE = BSD-2-Clause
PYTHON_DECORATOR_LICENSE_FILES = LICENSE.txt
PYTHON_DECORATOR_CPE_ID_VENDOR = python
PYTHON_DECORATOR_CPE_ID_PRODUCT = decorator
PYTHON_DECORATOR_SETUP_TYPE = setuptools
HOST_PYTHON_DECORATOR_NEEDS_HOST_PYTHON = python3

$(eval $(python-package))
$(eval $(host-python-package))

################################################################################
#
# python-executing
#
################################################################################

PYTHON_EXECUTING_VERSION = 2.0.1
PYTHON_EXECUTING_SOURCE = executing-$(PYTHON_EXECUTING_VERSION).tar.gz
PYTHON_EXECUTING_SITE = https://files.pythonhosted.org/packages/08/41/85d2d28466fca93737592b7f3cc456d1cfd6bcd401beceeba17e8e792b50
PYTHON_EXECUTING_SETUP_TYPE = setuptools
PYTHON_EXECUTING_LICENSE = MIT
PYTHON_EXECUTING_LICENSE_FILES = LICENSE.txt

PYTHON_EXECUTING_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

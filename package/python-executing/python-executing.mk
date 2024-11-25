################################################################################
#
# python-executing
#
################################################################################

PYTHON_EXECUTING_VERSION = 2.1.0
PYTHON_EXECUTING_SOURCE = executing-$(PYTHON_EXECUTING_VERSION).tar.gz
PYTHON_EXECUTING_SITE = https://files.pythonhosted.org/packages/8c/e3/7d45f492c2c4a0e8e0fad57d081a7c8a0286cdd86372b070cca1ec0caa1e
PYTHON_EXECUTING_SETUP_TYPE = setuptools
PYTHON_EXECUTING_LICENSE = MIT
PYTHON_EXECUTING_LICENSE_FILES = LICENSE.txt

PYTHON_EXECUTING_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

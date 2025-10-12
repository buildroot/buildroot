################################################################################
#
# python-executing
#
################################################################################

PYTHON_EXECUTING_VERSION = 2.2.1
PYTHON_EXECUTING_SOURCE = executing-$(PYTHON_EXECUTING_VERSION).tar.gz
PYTHON_EXECUTING_SITE = https://files.pythonhosted.org/packages/cc/28/c14e053b6762b1044f34a13aab6859bbf40456d37d23aa286ac24cfd9a5d
PYTHON_EXECUTING_SETUP_TYPE = setuptools
PYTHON_EXECUTING_LICENSE = MIT
PYTHON_EXECUTING_LICENSE_FILES = LICENSE.txt

PYTHON_EXECUTING_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

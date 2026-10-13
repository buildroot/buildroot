################################################################################
#
# python-executing
#
################################################################################

PYTHON_EXECUTING_VERSION = 2.3.0
PYTHON_EXECUTING_SOURCE = executing-$(PYTHON_EXECUTING_VERSION).tar.gz
PYTHON_EXECUTING_SITE = https://files.pythonhosted.org/packages/52/92/8a611141e42930c0f194f7504063ab87dfe970cf1a5af28e7703df448734
PYTHON_EXECUTING_SETUP_TYPE = setuptools
PYTHON_EXECUTING_LICENSE = MIT
PYTHON_EXECUTING_LICENSE_FILES = LICENSE.txt

PYTHON_EXECUTING_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

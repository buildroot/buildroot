################################################################################
#
# python-executing
#
################################################################################

PYTHON_EXECUTING_VERSION = 2.2.0
PYTHON_EXECUTING_SOURCE = executing-$(PYTHON_EXECUTING_VERSION).tar.gz
PYTHON_EXECUTING_SITE = https://files.pythonhosted.org/packages/91/50/a9d80c47ff289c611ff12e63f7c5d13942c65d68125160cefd768c73e6e4
PYTHON_EXECUTING_SETUP_TYPE = setuptools
PYTHON_EXECUTING_LICENSE = MIT
PYTHON_EXECUTING_LICENSE_FILES = LICENSE.txt

PYTHON_EXECUTING_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

################################################################################
#
# python-dtschema
#
################################################################################

PYTHON_DTSCHEMA_VERSION = 2022.11
PYTHON_DTSCHEMA_SOURCE = dtschema-$(PYTHON_DTSCHEMA_VERSION).tar.gz
PYTHON_DTSCHEMA_SITE = https://files.pythonhosted.org/packages/9a/15/41ece48fc9524ad815238cfbd164b8ac9dde889759790afbcc4903564dbd
PYTHON_DTSCHEMA_SETUP_TYPE = setuptools
PYTHON_DTSCHEMA_LICENSE = BSD-2-Clause
PYTHON_DTSCHEMA_LICENSE_FILES = LICENSE.txt
PYTHON_DTSCHEMA_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

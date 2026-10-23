################################################################################
#
# python-wtforms
#
################################################################################

PYTHON_WTFORMS_VERSION = 3.3.0
PYTHON_WTFORMS_SOURCE = wtforms-$(PYTHON_WTFORMS_VERSION).tar.gz
PYTHON_WTFORMS_SITE = https://files.pythonhosted.org/packages/c4/42/db38b45b7d791f608d7f1afbb9176dfef4a0dec415eb435b07cd44eb96cf
PYTHON_WTFORMS_SETUP_TYPE = hatch
PYTHON_WTFORMS_LICENSE = BSD-3-Clause
PYTHON_WTFORMS_LICENSE_FILES = LICENSE.rst docs/license.rst
PYTHON_WTFORMS_DEPENDENCIES = host-python-babel

$(eval $(python-package))

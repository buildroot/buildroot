################################################################################
#
# python-wtforms
#
################################################################################

PYTHON_WTFORMS_VERSION = 3.0.1
PYTHON_WTFORMS_SOURCE = WTForms-$(PYTHON_WTFORMS_VERSION).tar.gz
PYTHON_WTFORMS_SITE = https://files.pythonhosted.org/packages/9a/7d/d4aa68f5bfcb91dd61a7faf0e862512ae7b3d531c41f24c217910aec0559
PYTHON_WTFORMS_SETUP_TYPE = setuptools
PYTHON_WTFORMS_LICENSE = BSD-3-Clause
PYTHON_WTFORMS_LICENSE_FILES = LICENSE.rst docs/license.rst
PYTHON_WTFORMS_DEPENDENCIES = host-python-babel

$(eval $(python-package))

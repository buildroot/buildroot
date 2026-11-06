################################################################################
#
# python-wtforms
#
################################################################################

PYTHON_WTFORMS_VERSION = 3.3.2
PYTHON_WTFORMS_SOURCE = wtforms-$(PYTHON_WTFORMS_VERSION).tar.gz
PYTHON_WTFORMS_SITE = https://files.pythonhosted.org/packages/52/3f/742cb21320840bcd80bf9de3d0486126f364664fff12b805086371b1fd1a
PYTHON_WTFORMS_SETUP_TYPE = hatch
PYTHON_WTFORMS_LICENSE = BSD-3-Clause
PYTHON_WTFORMS_LICENSE_FILES = LICENSE.rst docs/license.rst
PYTHON_WTFORMS_DEPENDENCIES = host-python-babel

$(eval $(python-package))

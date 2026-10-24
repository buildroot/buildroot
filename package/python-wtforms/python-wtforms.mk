################################################################################
#
# python-wtforms
#
################################################################################

PYTHON_WTFORMS_VERSION = 3.3.1
PYTHON_WTFORMS_SOURCE = wtforms-$(PYTHON_WTFORMS_VERSION).tar.gz
PYTHON_WTFORMS_SITE = https://files.pythonhosted.org/packages/ef/5b/588dc20774f4cebeac23908a87e493f2f6fb2a4c54756675cd59afb8cc72
PYTHON_WTFORMS_SETUP_TYPE = hatch
PYTHON_WTFORMS_LICENSE = BSD-3-Clause
PYTHON_WTFORMS_LICENSE_FILES = LICENSE.rst docs/license.rst
PYTHON_WTFORMS_DEPENDENCIES = host-python-babel

$(eval $(python-package))

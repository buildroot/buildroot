################################################################################
#
# python-stack-data
#
################################################################################

PYTHON_STACK_DATA_VERSION = 0.6.3
PYTHON_STACK_DATA_SOURCE = stack_data-$(PYTHON_STACK_DATA_VERSION).tar.gz
PYTHON_STACK_DATA_SITE = https://files.pythonhosted.org/packages/28/e3/55dcc2cfbc3ca9c29519eb6884dd1415ecb53b0e934862d3559ddcb7e20b
PYTHON_STACK_DATA_SETUP_TYPE = pep517
PYTHON_STACK_DATA_LICENSE = MIT
PYTHON_STACK_DATA_LICENSE_FILES = LICENSE.txt
PYTHON_STACK_DATA_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

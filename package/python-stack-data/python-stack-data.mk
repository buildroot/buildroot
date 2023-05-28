################################################################################
#
# python-stack-data
#
################################################################################

PYTHON_STACK_DATA_VERSION = 0.6.2
PYTHON_STACK_DATA_SOURCE = stack_data-$(PYTHON_STACK_DATA_VERSION).tar.gz
PYTHON_STACK_DATA_SITE = https://files.pythonhosted.org/packages/db/18/aa7f2b111aeba2cd83503254d9133a912d7f61f459a0c8561858f0d72a56
PYTHON_STACK_DATA_SETUP_TYPE = setuptools
PYTHON_STACK_DATA_LICENSE = MIT
PYTHON_STACK_DATA_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))

################################################################################
#
# python-treq
#
################################################################################

PYTHON_TREQ_VERSION = 26.7.0
PYTHON_TREQ_SOURCE = treq-$(PYTHON_TREQ_VERSION).tar.gz
PYTHON_TREQ_SITE = https://files.pythonhosted.org/packages/92/13/96aceb81d076eea518bf174048db701ac8b139c7aed1082913318a55a7d2
PYTHON_TREQ_LICENSE = MIT
PYTHON_TREQ_LICENSE_FILES = LICENSE
PYTHON_TREQ_SETUP_TYPE = hatch
PYTHON_TREQ_DEPENDENCIES = host-python-incremental

$(eval $(python-package))

################################################################################
#
# python-types-python-dateutil
#
################################################################################

PYTHON_TYPES_PYTHON_DATEUTIL_VERSION = 2.8.19.14
PYTHON_TYPES_PYTHON_DATEUTIL_SOURCE = types-python-dateutil-$(PYTHON_TYPES_PYTHON_DATEUTIL_VERSION).tar.gz
PYTHON_TYPES_PYTHON_DATEUTIL_SITE = https://files.pythonhosted.org/packages/1b/2d/f189e5c03c22700c4ce5aece4b51bb73fa8adcfd7848629de0fb78af5f6f
PYTHON_TYPES_PYTHON_DATEUTIL_SETUP_TYPE = setuptools
PYTHON_TYPES_PYTHON_DATEUTIL_LICENSE = Apache-2.0

$(eval $(python-package))

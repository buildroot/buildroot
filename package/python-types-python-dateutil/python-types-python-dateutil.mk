################################################################################
#
# python-types-python-dateutil
#
################################################################################

PYTHON_TYPES_PYTHON_DATEUTIL_VERSION = 2.9.0.20241003
PYTHON_TYPES_PYTHON_DATEUTIL_SOURCE = types-python-dateutil-$(PYTHON_TYPES_PYTHON_DATEUTIL_VERSION).tar.gz
PYTHON_TYPES_PYTHON_DATEUTIL_SITE = https://files.pythonhosted.org/packages/31/f8/f6ee4c803a7beccffee21bb29a71573b39f7037c224843eff53e5308c16e
PYTHON_TYPES_PYTHON_DATEUTIL_SETUP_TYPE = setuptools
PYTHON_TYPES_PYTHON_DATEUTIL_LICENSE = Apache-2.0

$(eval $(python-package))

################################################################################
#
# python-types-python-dateutil
#
################################################################################

PYTHON_TYPES_PYTHON_DATEUTIL_VERSION = 2.9.0.20260807
PYTHON_TYPES_PYTHON_DATEUTIL_SOURCE = types_python_dateutil-$(PYTHON_TYPES_PYTHON_DATEUTIL_VERSION).tar.gz
PYTHON_TYPES_PYTHON_DATEUTIL_SITE = https://files.pythonhosted.org/packages/c8/4e/b3fa538f9cb38dfece0d6ccf6d3d0d925bdedb144fb9c8129dfc007cd003
PYTHON_TYPES_PYTHON_DATEUTIL_SETUP_TYPE = setuptools
PYTHON_TYPES_PYTHON_DATEUTIL_LICENSE = Apache-2.0
PYTHON_TYPES_PYTHON_DATEUTIL_LICENSE_FILES = LICENSE

$(eval $(python-package))

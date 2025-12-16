################################################################################
#
# python-types-python-dateutil
#
################################################################################

PYTHON_TYPES_PYTHON_DATEUTIL_VERSION = 2.9.0.20251115
PYTHON_TYPES_PYTHON_DATEUTIL_SOURCE = types_python_dateutil-$(PYTHON_TYPES_PYTHON_DATEUTIL_VERSION).tar.gz
PYTHON_TYPES_PYTHON_DATEUTIL_SITE = https://files.pythonhosted.org/packages/6a/36/06d01fb52c0d57e9ad0c237654990920fa41195e4b3d640830dabf9eeb2f
PYTHON_TYPES_PYTHON_DATEUTIL_SETUP_TYPE = setuptools
PYTHON_TYPES_PYTHON_DATEUTIL_LICENSE = Apache-2.0
PYTHON_TYPES_PYTHON_DATEUTIL_LICENSE_FILES = LICENSE

$(eval $(python-package))

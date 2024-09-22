################################################################################
#
# python-types-python-dateutil
#
################################################################################

PYTHON_TYPES_PYTHON_DATEUTIL_VERSION = 2.9.0.20240906
PYTHON_TYPES_PYTHON_DATEUTIL_SOURCE = types-python-dateutil-$(PYTHON_TYPES_PYTHON_DATEUTIL_VERSION).tar.gz
PYTHON_TYPES_PYTHON_DATEUTIL_SITE = https://files.pythonhosted.org/packages/3e/d9/9c9ec2d870af7aa9b722ce4fd5890bb55b1d18898df7f1d069cab194bb2a
PYTHON_TYPES_PYTHON_DATEUTIL_SETUP_TYPE = setuptools
PYTHON_TYPES_PYTHON_DATEUTIL_LICENSE = Apache-2.0

$(eval $(python-package))

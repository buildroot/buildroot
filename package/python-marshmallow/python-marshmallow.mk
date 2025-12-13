################################################################################
#
# python-marshmallow
#
################################################################################

PYTHON_MARSHMALLOW_VERSION = 4.1.1
PYTHON_MARSHMALLOW_SOURCE = marshmallow-$(PYTHON_MARSHMALLOW_VERSION).tar.gz
PYTHON_MARSHMALLOW_SITE = https://files.pythonhosted.org/packages/4f/81/edb105b3296712a282680bc1ae02b8c1bb45d8f1edad3ff9fab1d41e9507
PYTHON_MARSHMALLOW_SETUP_TYPE = flit
PYTHON_MARSHMALLOW_LICENSE = MIT
PYTHON_MARSHMALLOW_LICENSE_FILES = LICENSE docs/license.rst
PYTHON_MARSHMALLOW_CPE_ID_VENDOR = marshmallow_project
PYTHON_MARSHMALLOW_CPE_ID_PRODUCT = marshmallow

$(eval $(python-package))

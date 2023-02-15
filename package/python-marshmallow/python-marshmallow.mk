################################################################################
#
# python-marshmallow
#
################################################################################

PYTHON_MARSHMALLOW_VERSION = 3.19.0
PYTHON_MARSHMALLOW_SOURCE = marshmallow-$(PYTHON_MARSHMALLOW_VERSION).tar.gz
PYTHON_MARSHMALLOW_SITE = https://files.pythonhosted.org/packages/5e/59/dd465e5ab0ccb879c410f88c75189a19fd437b12cd9a03b31579aef58709
PYTHON_MARSHMALLOW_SETUP_TYPE = setuptools
PYTHON_MARSHMALLOW_LICENSE = MIT
PYTHON_MARSHMALLOW_LICENSE_FILES = LICENSE
PYTHON_MARSHMALLOW_CPE_ID_VENDOR = marshmallow_project
PYTHON_MARSHMALLOW_CPE_ID_PRODUCT = marshmallow

$(eval $(python-package))

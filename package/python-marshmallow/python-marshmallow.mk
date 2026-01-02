################################################################################
#
# python-marshmallow
#
################################################################################

PYTHON_MARSHMALLOW_VERSION = 4.1.2
PYTHON_MARSHMALLOW_SOURCE = marshmallow-$(PYTHON_MARSHMALLOW_VERSION).tar.gz
PYTHON_MARSHMALLOW_SITE = https://files.pythonhosted.org/packages/e9/e1/5edfd1edf05d3cc98415b0810ca45fa19d7dee6def0d0ec639eb4eb14e20
PYTHON_MARSHMALLOW_SETUP_TYPE = flit
PYTHON_MARSHMALLOW_LICENSE = MIT
PYTHON_MARSHMALLOW_LICENSE_FILES = LICENSE docs/license.rst
PYTHON_MARSHMALLOW_CPE_ID_VENDOR = marshmallow_project
PYTHON_MARSHMALLOW_CPE_ID_PRODUCT = marshmallow

$(eval $(python-package))

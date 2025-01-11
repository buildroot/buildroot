################################################################################
#
# python-marshmallow
#
################################################################################

PYTHON_MARSHMALLOW_VERSION = 3.25.0
PYTHON_MARSHMALLOW_SOURCE = marshmallow-$(PYTHON_MARSHMALLOW_VERSION).tar.gz
PYTHON_MARSHMALLOW_SITE = https://files.pythonhosted.org/packages/bd/5c/cbfa41491d6c83b36471f2a2f75602349d20a8f88afd94f83c1e68bbc298
PYTHON_MARSHMALLOW_SETUP_TYPE = flit
PYTHON_MARSHMALLOW_LICENSE = MIT
PYTHON_MARSHMALLOW_LICENSE_FILES = LICENSE docs/license.rst
PYTHON_MARSHMALLOW_CPE_ID_VENDOR = marshmallow_project
PYTHON_MARSHMALLOW_CPE_ID_PRODUCT = marshmallow

$(eval $(python-package))

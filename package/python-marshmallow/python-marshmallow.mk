################################################################################
#
# python-marshmallow
#
################################################################################

PYTHON_MARSHMALLOW_VERSION = 4.2.2
PYTHON_MARSHMALLOW_SOURCE = marshmallow-$(PYTHON_MARSHMALLOW_VERSION).tar.gz
PYTHON_MARSHMALLOW_SITE = https://files.pythonhosted.org/packages/f9/03/261af5efb3d3ce0e2db3fd1e11dc5a96b74a4fb76e488da1c845a8f12345
PYTHON_MARSHMALLOW_SETUP_TYPE = flit
PYTHON_MARSHMALLOW_LICENSE = MIT
PYTHON_MARSHMALLOW_LICENSE_FILES = LICENSE docs/license.rst
PYTHON_MARSHMALLOW_CPE_ID_VENDOR = marshmallow_project
PYTHON_MARSHMALLOW_CPE_ID_PRODUCT = marshmallow

$(eval $(python-package))

################################################################################
#
# python-cssselect2
#
################################################################################

PYTHON_CSSSELECT2_VERSION = 0.6.0
PYTHON_CSSSELECT2_SOURCE = cssselect2-$(PYTHON_CSSSELECT2_VERSION).tar.gz
PYTHON_CSSSELECT2_SITE = https://files.pythonhosted.org/packages/68/62/b6a16d0c32bb088079f344202e3cd0936380a4d8cb23ef9b1f8079ff8612
PYTHON_CSSSELECT2_SETUP_TYPE = flit
PYTHON_CSSSELECT2_LICENSE = BSD-3-Clause
PYTHON_CSSSELECT2_LICENSE_FILES = LICENSE

$(eval $(python-package))

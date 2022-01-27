################################################################################
#
# python-cssselect2
#
################################################################################

PYTHON_CSSSELECT2_VERSION = 0.4.1
PYTHON_CSSSELECT2_SOURCE = cssselect2-$(PYTHON_CSSSELECT2_VERSION).tar.gz
PYTHON_CSSSELECT2_SITE = https://files.pythonhosted.org/packages/ad/3d/fb764303deb34cbc1a32fcecdfd239367cb16323920c88390b2f5ad751f0
PYTHON_CSSSELECT2_SETUP_TYPE = distutils
PYTHON_CSSSELECT2_LICENSE = BSD-3-Clause
PYTHON_CSSSELECT2_LICENSE_FILES = LICENSE

$(eval $(python-package))

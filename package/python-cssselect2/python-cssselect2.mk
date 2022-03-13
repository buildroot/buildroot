################################################################################
#
# python-cssselect2
#
################################################################################

PYTHON_CSSSELECT2_VERSION = 0.5.0
PYTHON_CSSSELECT2_SOURCE = cssselect2-$(PYTHON_CSSSELECT2_VERSION).tar.gz
PYTHON_CSSSELECT2_SITE = https://files.pythonhosted.org/packages/ce/e7/1333b9042beb33a9bb425900b6d9b59035b98c31c950a323d14ceca1275e
PYTHON_CSSSELECT2_SETUP_TYPE = flit
PYTHON_CSSSELECT2_LICENSE = BSD-3-Clause
PYTHON_CSSSELECT2_LICENSE_FILES = LICENSE

$(eval $(python-package))

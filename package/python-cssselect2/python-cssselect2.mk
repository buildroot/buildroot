################################################################################
#
# python-cssselect2
#
################################################################################

PYTHON_CSSSELECT2_VERSION = 0.9.0
PYTHON_CSSSELECT2_SOURCE = cssselect2-$(PYTHON_CSSSELECT2_VERSION).tar.gz
PYTHON_CSSSELECT2_SITE = https://files.pythonhosted.org/packages/e0/20/92eaa6b0aec7189fa4b75c890640e076e9e793095721db69c5c81142c2e1
PYTHON_CSSSELECT2_SETUP_TYPE = flit
PYTHON_CSSSELECT2_LICENSE = BSD-3-Clause
PYTHON_CSSSELECT2_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-cssselect2
#
################################################################################

PYTHON_CSSSELECT2_VERSION = 0.8.0
PYTHON_CSSSELECT2_SOURCE = cssselect2-$(PYTHON_CSSSELECT2_VERSION).tar.gz
PYTHON_CSSSELECT2_SITE = https://files.pythonhosted.org/packages/9f/86/fd7f58fc498b3166f3a7e8e0cddb6e620fe1da35b02248b1bd59e95dbaaa
PYTHON_CSSSELECT2_SETUP_TYPE = flit
PYTHON_CSSSELECT2_LICENSE = BSD-3-Clause
PYTHON_CSSSELECT2_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-cssselect
#
################################################################################

PYTHON_CSSSELECT_VERSION = 1.2.0
PYTHON_CSSSELECT_SOURCE = cssselect-$(PYTHON_CSSSELECT_VERSION).tar.gz
PYTHON_CSSSELECT_SITE = https://files.pythonhosted.org/packages/d1/91/d51202cc41fbfca7fa332f43a5adac4b253962588c7cc5a54824b019081c
PYTHON_CSSSELECT_SETUP_TYPE = setuptools
PYTHON_CSSSELECT_LICENSE = BSD-3-Clause
PYTHON_CSSSELECT_LICENSE_FILES = LICENSE

$(eval $(python-package))

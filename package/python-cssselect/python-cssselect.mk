################################################################################
#
# python-cssselect
#
################################################################################

PYTHON_CSSSELECT_VERSION = 1.5.0
PYTHON_CSSSELECT_SOURCE = cssselect-$(PYTHON_CSSSELECT_VERSION).tar.gz
PYTHON_CSSSELECT_SITE = https://files.pythonhosted.org/packages/8e/5a/6d6fcf922709391fac986f0a03ad4546f4f45b94d10aeb6c1ee041599993
PYTHON_CSSSELECT_SETUP_TYPE = hatch
PYTHON_CSSSELECT_LICENSE = BSD-3-Clause
PYTHON_CSSSELECT_LICENSE_FILES = LICENSE

$(eval $(python-package))

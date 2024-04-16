################################################################################
#
# python-argh
#
################################################################################

PYTHON_ARGH_VERSION = 0.31.0
PYTHON_ARGH_SOURCE = argh-$(PYTHON_ARGH_VERSION).tar.gz
PYTHON_ARGH_SITE = https://files.pythonhosted.org/packages/7c/3c/1b7f3fab380c96d61119178040c0183161fe0f182c4da3933bcb3284538f
PYTHON_ARGH_SETUP_TYPE = flit
PYTHON_ARGH_LICENSE = LGPL-3.0+
PYTHON_ARGH_LICENSE_FILES = COPYING COPYING.LESSER

$(eval $(python-package))

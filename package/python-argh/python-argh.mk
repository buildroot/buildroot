################################################################################
#
# python-argh
#
################################################################################

PYTHON_ARGH_VERSION = 0.31.3
PYTHON_ARGH_SOURCE = argh-$(PYTHON_ARGH_VERSION).tar.gz
PYTHON_ARGH_SITE = https://files.pythonhosted.org/packages/4f/34/bc0b3577a818b4b70c6e318d23fe3c81fc3bb25f978ca8a3965cd8ee3af9
PYTHON_ARGH_SETUP_TYPE = flit
PYTHON_ARGH_LICENSE = LGPL-3.0+
PYTHON_ARGH_LICENSE_FILES = COPYING COPYING.LESSER

$(eval $(python-package))

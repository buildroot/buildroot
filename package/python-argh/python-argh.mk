################################################################################
#
# python-argh
#
################################################################################

PYTHON_ARGH_VERSION = 0.30.4
PYTHON_ARGH_SOURCE = argh-$(PYTHON_ARGH_VERSION).tar.gz
PYTHON_ARGH_SITE = https://files.pythonhosted.org/packages/37/3a/175f4a2c47e8c20e59cf25fe69546f76cf1196251a377b182e8f4542b4c4
PYTHON_ARGH_SETUP_TYPE = flit
PYTHON_ARGH_LICENSE = LGPL-3.0+
PYTHON_ARGH_LICENSE_FILES = COPYING COPYING.LESSER

$(eval $(python-package))

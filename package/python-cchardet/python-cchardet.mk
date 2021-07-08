################################################################################
#
# python-cchardet
#
################################################################################

PYTHON_CCHARDET_VERSION = 2.1.7
PYTHON_CCHARDET_SOURCE = cchardet-$(PYTHON_CCHARDET_VERSION).tar.gz
PYTHON_CCHARDET_SITE = https://files.pythonhosted.org/packages/a8/5d/090c9f0312b7988a9433246c9cf0b566b1ae1374368cfb8ac897218a4f65
PYTHON_CCHARDET_SETUP_TYPE = setuptools
PYTHON_CCHARDET_LICENSE = MPL-1.1
PYTHON_CCHARDET_LICENSE_FILES = COPYING

$(eval $(python-package))

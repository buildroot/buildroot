################################################################################
#
# python-cchardet
#
################################################################################

PYTHON_CCHARDET_VERSION = 2.4.0
PYTHON_CCHARDET_SOURCE = cchardet-$(PYTHON_CCHARDET_VERSION).tar.gz
PYTHON_CCHARDET_SITE = https://files.pythonhosted.org/packages/ae/f2/4db3f22a942ab99fbf4860bfc8594ac753ff0601e84d82b20f670e55280e
PYTHON_CCHARDET_SETUP_TYPE = setuptools
PYTHON_CCHARDET_LICENSE = MPL-1.1
PYTHON_CCHARDET_LICENSE_FILES = COPYING
PYTHON_CCHARDET_DEPENDENCIES = host-python-cython

$(eval $(python-package))

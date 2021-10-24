################################################################################
#
# python-pyndiff
#
################################################################################

PYTHON_PYNDIFF_VERSION = 1.0.2
PYTHON_PYNDIFF_SOURCE = pyndiff-$(PYTHON_PYNDIFF_VERSION).tar.gz
PYTHON_PYNDIFF_SITE = https://files.pythonhosted.org/packages/83/3b/fb13918710c4fba40367140f22e3449998f4f66869a7564d0e547ad99ef8
PYTHON_PYNDIFF_SETUP_TYPE = setuptools
PYTHON_PYNDIFF_LICENSE = Apache-2.0
PYTHON_PYNDIFF_LICENSE_FILES = LICENSE

$(eval $(python-package))

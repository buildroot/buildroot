################################################################################
#
# python-iterable-io
#
################################################################################

PYTHON_ITERABLE_IO_VERSION = 1.0.0
PYTHON_ITERABLE_IO_SOURCE = iterable-io-$(PYTHON_ITERABLE_IO_VERSION).tar.gz
PYTHON_ITERABLE_IO_SITE = https://files.pythonhosted.org/packages/40/be/27d59b5c1d74ecbd26c1142f84b61d6cb04f0d0337697149645f34406b2d
PYTHON_ITERABLE_IO_SETUP_TYPE = setuptools
PYTHON_ITERABLE_IO_LICENSE = LGPL-3.0
PYTHON_ITERABLE_IO_LICENSE_FILES = README.md

$(eval $(python-package))

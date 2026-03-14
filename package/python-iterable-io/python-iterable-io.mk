################################################################################
#
# python-iterable-io
#
################################################################################

PYTHON_ITERABLE_IO_VERSION = 1.0.1
PYTHON_ITERABLE_IO_SOURCE = iterable_io-$(PYTHON_ITERABLE_IO_VERSION).tar.gz
PYTHON_ITERABLE_IO_SITE = https://files.pythonhosted.org/packages/9e/ad/cc53869e3357520033e3ab9a7d6043045bcdd666da427583678efdbb446e
PYTHON_ITERABLE_IO_SETUP_TYPE = setuptools
PYTHON_ITERABLE_IO_LICENSE = LGPL-3.0
PYTHON_ITERABLE_IO_LICENSE_FILES = README.md

$(eval $(python-package))

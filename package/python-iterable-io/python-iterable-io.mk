################################################################################
#
# python-iterable-io
#
################################################################################

PYTHON_ITERABLE_IO_VERSION = 1.0.4
PYTHON_ITERABLE_IO_SOURCE = iterable_io-$(PYTHON_ITERABLE_IO_VERSION).tar.gz
PYTHON_ITERABLE_IO_SITE = https://files.pythonhosted.org/packages/0f/c5/c3578d4ebc1f0e80c1a321b9f81a74c4486a6ad48e2a3dd1d228e3ba6199
PYTHON_ITERABLE_IO_SETUP_TYPE = hatch
PYTHON_ITERABLE_IO_LICENSE = LGPL-3.0
PYTHON_ITERABLE_IO_LICENSE_FILES = README.md

$(eval $(python-package))

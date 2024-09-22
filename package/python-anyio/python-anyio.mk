################################################################################
#
# python-anyio
#
################################################################################

PYTHON_ANYIO_VERSION = 4.6.0
PYTHON_ANYIO_SOURCE = anyio-$(PYTHON_ANYIO_VERSION).tar.gz
PYTHON_ANYIO_SITE = https://files.pythonhosted.org/packages/78/49/f3f17ec11c4a91fe79275c426658e509b07547f874b14c1a526d86a83fc8
PYTHON_ANYIO_SETUP_TYPE = setuptools
PYTHON_ANYIO_LICENSE = MIT
PYTHON_ANYIO_LICENSE_FILES = LICENSE
PYTHON_ANYIO_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

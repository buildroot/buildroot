################################################################################
#
# python-anyio
#
################################################################################

PYTHON_ANYIO_VERSION = 4.10.0
PYTHON_ANYIO_SOURCE = anyio-$(PYTHON_ANYIO_VERSION).tar.gz
PYTHON_ANYIO_SITE = https://files.pythonhosted.org/packages/f1/b4/636b3b65173d3ce9a38ef5f0522789614e590dab6a8d505340a4efe4c567
PYTHON_ANYIO_SETUP_TYPE = setuptools
PYTHON_ANYIO_LICENSE = MIT
PYTHON_ANYIO_LICENSE_FILES = LICENSE
PYTHON_ANYIO_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

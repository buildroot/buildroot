################################################################################
#
# python-engineio
#
################################################################################

PYTHON_ENGINEIO_VERSION = 4.11.1
PYTHON_ENGINEIO_SOURCE = python_engineio-$(PYTHON_ENGINEIO_VERSION).tar.gz
PYTHON_ENGINEIO_SITE = https://files.pythonhosted.org/packages/17/54/39e4c942296943cc79a1fd7d744a1a10ba2fc3af59293f26a8bd48c2aa74
PYTHON_ENGINEIO_SETUP_TYPE = setuptools
PYTHON_ENGINEIO_LICENSE = MIT
PYTHON_ENGINEIO_LICENSE_FILES = LICENSE
PYTHON_ENGINEIO_CPE_ID_VALID = YES

$(eval $(python-package))

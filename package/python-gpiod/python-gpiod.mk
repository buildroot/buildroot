################################################################################
#
# python-gpiod
#
################################################################################

PYTHON_GPIOD_VERSION = 2.4.0
PYTHON_GPIOD_SOURCE = gpiod-$(PYTHON_GPIOD_VERSION).tar.gz
PYTHON_GPIOD_SITE = https://files.pythonhosted.org/packages/0c/dc/5a6bd309345bd9cfa7e098174ab7e65367e408539b6c1998e4f267c673cd
PYTHON_GPIOD_SETUP_TYPE = setuptools
PYTHON_GPIOD_LICENSE = LGPL-2.1+
# The package license follows libgpiod's license but doesn't include the LICENSE text in the pypi distrobuted package again
PYTHON_GPIOD_LICENSE_FILES = pyproject.toml
PYTHON_GPIOD_DEPENDENCIES = libgpiod2
PYTHON_GPIOD_ENV = LINK_SYSTEM_LIBGPIOD=1

$(eval $(python-package))

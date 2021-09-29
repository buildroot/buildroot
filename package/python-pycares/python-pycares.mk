################################################################################
#
# python-pycares
#
################################################################################

PYTHON_PYCARES_VERSION = 4.0.0
PYTHON_PYCARES_SOURCE = pycares-$(PYTHON_PYCARES_VERSION).tar.gz
PYTHON_PYCARES_SITE = https://files.pythonhosted.org/packages/25/5a/ed8cc3340b7e83a5e572b5d27387a968a7e52b1e3c269442076ca902b7ba
PYTHON_PYCARES_SETUP_TYPE = setuptools
PYTHON_PYCARES_LICENSE = MIT
PYTHON_PYCARES_LICENSE_FILES = LICENSE
PYTHON_PYCARES_DEPENDENCIES = host-python-cffi

$(eval $(python-package))

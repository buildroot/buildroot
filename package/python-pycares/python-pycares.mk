################################################################################
#
# python-pycares
#
################################################################################

PYTHON_PYCARES_VERSION = 5.1.0
PYTHON_PYCARES_SOURCE = pycares-$(PYTHON_PYCARES_VERSION).tar.gz
PYTHON_PYCARES_SITE = https://files.pythonhosted.org/packages/3f/b9/8f8389df1dfe3c9f6b5b02cfab60781685d146bee529e7628b77a1df7e9c
PYTHON_PYCARES_SETUP_TYPE = setuptools
PYTHON_PYCARES_LICENSE = MIT
PYTHON_PYCARES_LICENSE_FILES = LICENSE
PYTHON_PYCARES_DEPENDENCIES = c-ares host-python-cffi
PYTHON_PYCARES_ENV = PYCARES_USE_SYSTEM_LIB=1

$(eval $(python-package))

################################################################################
#
# python-pycares
#
################################################################################

PYTHON_PYCARES_VERSION = 5.2.0
PYTHON_PYCARES_SOURCE = pycares-$(PYTHON_PYCARES_VERSION).tar.gz
PYTHON_PYCARES_SITE = https://files.pythonhosted.org/packages/e1/16/66c5e0498934011d36887d69ce116e347253399d06931a6ca900c7cc0899
PYTHON_PYCARES_SETUP_TYPE = setuptools
PYTHON_PYCARES_LICENSE = MIT
PYTHON_PYCARES_LICENSE_FILES = LICENSE
PYTHON_PYCARES_DEPENDENCIES = c-ares host-python-cffi
PYTHON_PYCARES_ENV = PYCARES_USE_SYSTEM_LIB=1

$(eval $(python-package))

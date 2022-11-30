################################################################################
#
# python-pycares
#
################################################################################

PYTHON_PYCARES_VERSION = 4.2.2
PYTHON_PYCARES_SOURCE = pycares-$(PYTHON_PYCARES_VERSION).tar.gz
PYTHON_PYCARES_SITE = https://files.pythonhosted.org/packages/ac/a3/21594384c2398420dd7f6e8656aeb5a2c15128ddf2b85ef5f4403342e18d
PYTHON_PYCARES_SETUP_TYPE = setuptools
PYTHON_PYCARES_LICENSE = MIT
PYTHON_PYCARES_LICENSE_FILES = LICENSE
PYTHON_PYCARES_DEPENDENCIES = host-python-cffi

$(eval $(python-package))

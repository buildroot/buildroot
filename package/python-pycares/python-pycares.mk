################################################################################
#
# python-pycares
#
################################################################################

PYTHON_PYCARES_VERSION = 5.0.0
PYTHON_PYCARES_SOURCE = pycares-$(PYTHON_PYCARES_VERSION).tar.gz
PYTHON_PYCARES_SITE = https://files.pythonhosted.org/packages/59/5d/b50bdc30026f350f1c4b0c4fb6b7543598f2bcc370308c5148c7019d9886
PYTHON_PYCARES_SETUP_TYPE = setuptools
PYTHON_PYCARES_LICENSE = MIT
PYTHON_PYCARES_LICENSE_FILES = LICENSE
PYTHON_PYCARES_DEPENDENCIES = c-ares host-python-cffi
PYTHON_PYCARES_ENV = PYCARES_USE_SYSTEM_LIB=1

$(eval $(python-package))

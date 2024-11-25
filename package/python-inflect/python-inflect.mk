################################################################################
#
# python-inflect
#
################################################################################

PYTHON_INFLECT_VERSION = 7.4.0
PYTHON_INFLECT_SOURCE = inflect-$(PYTHON_INFLECT_VERSION).tar.gz
PYTHON_INFLECT_SITE = https://files.pythonhosted.org/packages/e1/dc/02614acece4d578e709c606594c989cfd9f15cf6401444e5603e60df9b26
PYTHON_INFLECT_SETUP_TYPE = setuptools
PYTHON_INFLECT_LICENSE = MIT
PYTHON_INFLECT_LICENSE_FILES = LICENSE
PYTHON_INFLECT_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

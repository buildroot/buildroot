################################################################################
#
# python-inflect
#
################################################################################

PYTHON_INFLECT_VERSION = 7.0.0
PYTHON_INFLECT_SOURCE = inflect-$(PYTHON_INFLECT_VERSION).tar.gz
PYTHON_INFLECT_SITE = https://files.pythonhosted.org/packages/9f/90/1d0a889847fdce963ebe9684de24a749e4fad627bf595e9f0d32730f85a8
PYTHON_INFLECT_SETUP_TYPE = setuptools
PYTHON_INFLECT_LICENSE = MIT
PYTHON_INFLECT_LICENSE_FILES = LICENSE
PYTHON_INFLECT_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

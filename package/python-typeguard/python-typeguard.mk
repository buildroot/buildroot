################################################################################
#
# python-typeguard
#
################################################################################

PYTHON_TYPEGUARD_VERSION = 4.4.4
PYTHON_TYPEGUARD_SOURCE = typeguard-$(PYTHON_TYPEGUARD_VERSION).tar.gz
PYTHON_TYPEGUARD_SITE = https://files.pythonhosted.org/packages/c7/68/71c1a15b5f65f40e91b65da23b8224dad41349894535a97f63a52e462196
PYTHON_TYPEGUARD_SETUP_TYPE = setuptools
PYTHON_TYPEGUARD_LICENSE = MIT
PYTHON_TYPEGUARD_LICENSE_FILES = LICENSE
PYTHON_TYPEGUARD_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

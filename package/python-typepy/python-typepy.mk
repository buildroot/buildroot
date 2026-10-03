################################################################################
#
# python-typepy
#
################################################################################

PYTHON_TYPEPY_VERSION = 2.0.0
PYTHON_TYPEPY_SOURCE = typepy-$(PYTHON_TYPEPY_VERSION).tar.gz
PYTHON_TYPEPY_SITE = https://files.pythonhosted.org/packages/28/c3/0c4382a6c70d0aa119bbf45c56340609c3f206b68756e7ff6b91abf83cd9
PYTHON_TYPEPY_SETUP_TYPE = setuptools
PYTHON_TYPEPY_LICENSE = MIT
PYTHON_TYPEPY_LICENSE_FILES = LICENSE
PYTHON_TYPEPY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

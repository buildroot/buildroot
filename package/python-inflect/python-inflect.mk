################################################################################
#
# python-inflect
#
################################################################################

PYTHON_INFLECT_VERSION = 7.5.0
PYTHON_INFLECT_SOURCE = inflect-$(PYTHON_INFLECT_VERSION).tar.gz
PYTHON_INFLECT_SITE = https://files.pythonhosted.org/packages/78/c6/943357d44a21fd995723d07ccaddd78023eace03c1846049a2645d4324a3
PYTHON_INFLECT_SETUP_TYPE = setuptools
PYTHON_INFLECT_LICENSE = MIT
PYTHON_INFLECT_LICENSE_FILES = LICENSE
PYTHON_INFLECT_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

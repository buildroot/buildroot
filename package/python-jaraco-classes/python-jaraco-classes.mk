################################################################################
#
# python-jaraco-classes
#
################################################################################

PYTHON_JARACO_CLASSES_VERSION = 3.2.3
PYTHON_JARACO_CLASSES_SOURCE = jaraco.classes-$(PYTHON_JARACO_CLASSES_VERSION).tar.gz
PYTHON_JARACO_CLASSES_SITE = https://files.pythonhosted.org/packages/bf/02/a956c9bfd2dfe60b30c065ed8e28df7fcf72b292b861dca97e951c145ef6
PYTHON_JARACO_CLASSES_LICENSE = MIT
PYTHON_JARACO_CLASSES_LICENSE_FILES = LICENSE
PYTHON_JARACO_CLASSES_SETUP_TYPE = setuptools
PYTHON_JARACO_CLASSES_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

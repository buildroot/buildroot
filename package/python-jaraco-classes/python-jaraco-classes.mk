################################################################################
#
# python-jaraco-classes
#
################################################################################

PYTHON_JARACO_CLASSES_VERSION = 3.4.0
PYTHON_JARACO_CLASSES_SOURCE = jaraco.classes-$(PYTHON_JARACO_CLASSES_VERSION).tar.gz
PYTHON_JARACO_CLASSES_SITE = https://files.pythonhosted.org/packages/06/c0/ed4a27bc5571b99e3cff68f8a9fa5b56ff7df1c2251cc715a652ddd26402
PYTHON_JARACO_CLASSES_LICENSE = MIT
PYTHON_JARACO_CLASSES_LICENSE_FILES = LICENSE
PYTHON_JARACO_CLASSES_SETUP_TYPE = setuptools
PYTHON_JARACO_CLASSES_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

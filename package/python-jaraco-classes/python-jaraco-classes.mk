################################################################################
#
# python-jaraco-classes
#
################################################################################

PYTHON_JARACO_CLASSES_VERSION = 3.3.0
PYTHON_JARACO_CLASSES_SOURCE = jaraco.classes-$(PYTHON_JARACO_CLASSES_VERSION).tar.gz
PYTHON_JARACO_CLASSES_SITE = https://files.pythonhosted.org/packages/8b/de/d0a466824ce8b53c474bb29344e6d6113023eb2c3793d1c58c0908588bfa
PYTHON_JARACO_CLASSES_LICENSE = MIT
PYTHON_JARACO_CLASSES_LICENSE_FILES = LICENSE
PYTHON_JARACO_CLASSES_SETUP_TYPE = setuptools
PYTHON_JARACO_CLASSES_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

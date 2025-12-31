################################################################################
#
# python-reedsolo
#
################################################################################

PYTHON_REEDSOLO_VERSION = 2.0.13
PYTHON_REEDSOLO_SOURCE = reedsolo-$(PYTHON_REEDSOLO_VERSION).tar.gz
PYTHON_REEDSOLO_SITE = https://files.pythonhosted.org/packages/57/5b/ead15a5d182553f9d7832851a954b7f0d662d710972b0d1c479fd11a3ebd
PYTHON_REEDSOLO_SETUP_TYPE = setuptools
PYTHON_REEDSOLO_LICENSE = MIT-0, Unlicense
PYTHON_REEDSOLO_LICENSE_FILES = LICENSE
PYTHON_REEDSOLO_DEPENDENCIES = host-python-cython
PYTHON_REEDSOLO_BUILD_OPTS = -C--build-option=--cythonize

$(eval $(python-package))

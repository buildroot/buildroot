################################################################################
#
# python-path
#
################################################################################

PYTHON_PATH_VERSION = 17.1.0
PYTHON_PATH_SOURCE = path-$(PYTHON_PATH_VERSION).tar.gz
PYTHON_PATH_SITE = https://files.pythonhosted.org/packages/ed/51/127cd9fa2baae5715e24839d6fb73c6fa6eca7b84a52fc7ce8195d830802
PYTHON_PATH_SETUP_TYPE = setuptools
PYTHON_PATH_LICENSE = MIT
PYTHON_PATH_LICENSE_FILES = LICENSE
PYTHON_PATH_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

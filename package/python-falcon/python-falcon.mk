################################################################################
#
# python-falcon
#
################################################################################

PYTHON_FALCON_VERSION = 4.2.0
PYTHON_FALCON_SOURCE = falcon-$(PYTHON_FALCON_VERSION).tar.gz
PYTHON_FALCON_SITE = https://files.pythonhosted.org/packages/ba/15/5a4d8d62e8b338d2ec4430965b51b592695e859d0c6bf104afa1ce927eed
PYTHON_FALCON_SETUP_TYPE = setuptools
PYTHON_FALCON_LICENSE = Apache-2.0
PYTHON_FALCON_LICENSE_FILES = LICENSE
PYTHON_FALCON_DEPENDENCIES += host-python-cython

$(eval $(python-package))

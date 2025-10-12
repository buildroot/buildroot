################################################################################
#
# python-falcon
#
################################################################################

PYTHON_FALCON_VERSION = 4.1.0
PYTHON_FALCON_SOURCE = falcon-$(PYTHON_FALCON_VERSION).tar.gz
PYTHON_FALCON_SITE = https://files.pythonhosted.org/packages/90/85/a4abc8357f6bc6b6b0b3d80e2c319c895900c518a3528279a222d7a53b7e
PYTHON_FALCON_SETUP_TYPE = setuptools
PYTHON_FALCON_LICENSE = Apache-2.0
PYTHON_FALCON_LICENSE_FILES = LICENSE
PYTHON_FALCON_DEPENDENCIES += host-python-cython

$(eval $(python-package))

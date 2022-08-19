################################################################################
#
# python-pybleno
#
################################################################################

PYTHON_PYBLENO_VERSION = 0.11
PYTHON_PYBLENO_SOURCE = pybleno-$(PYTHON_PYBLENO_VERSION).tar.gz
PYTHON_PYBLENO_SITE = https://files.pythonhosted.org/packages/87/70/6352d6441c33c6b0666ca64940d9ec5c597e839c539293ec27d20d14b919
PYTHON_PYBLENO_SETUP_TYPE = distutils
PYTHON_PYBLENO_LICENSE = 

$(eval $(python-package))

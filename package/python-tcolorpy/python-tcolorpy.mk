################################################################################
#
# python-tcolorpy
#
################################################################################

PYTHON_TCOLORPY_VERSION = 0.1.6
PYTHON_TCOLORPY_SOURCE = tcolorpy-$(PYTHON_TCOLORPY_VERSION).tar.gz
PYTHON_TCOLORPY_SITE = https://files.pythonhosted.org/packages/af/f6/b17885354c5addfb93c14f3ed7172c33494f989dd5f83c0340d2c8fa3b69
PYTHON_TCOLORPY_SETUP_TYPE = setuptools
PYTHON_TCOLORPY_LICENSE = MIT
PYTHON_TCOLORPY_LICENSE_FILES = LICENSE
PYTHON_TCOLORPY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

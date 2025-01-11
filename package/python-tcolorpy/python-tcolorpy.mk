################################################################################
#
# python-tcolorpy
#
################################################################################

PYTHON_TCOLORPY_VERSION = 0.1.7
PYTHON_TCOLORPY_SOURCE = tcolorpy-$(PYTHON_TCOLORPY_VERSION).tar.gz
PYTHON_TCOLORPY_SITE = https://files.pythonhosted.org/packages/80/cc/44f2d81d8f9093aad81c3467a5bf5718d2b5f786e887b6e4adcfc17ec6b9
PYTHON_TCOLORPY_SETUP_TYPE = setuptools
PYTHON_TCOLORPY_LICENSE = MIT
PYTHON_TCOLORPY_LICENSE_FILES = LICENSE
PYTHON_TCOLORPY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))

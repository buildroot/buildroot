################################################################################
#
# python-tcolorpy
#
################################################################################

PYTHON_TCOLORPY_VERSION = 0.1.4
PYTHON_TCOLORPY_SOURCE = tcolorpy-$(PYTHON_TCOLORPY_VERSION).tar.gz
PYTHON_TCOLORPY_SITE = https://files.pythonhosted.org/packages/ba/e0/20b99847e76bb89784b68634399261d770b01054bca16cd19a06ac9c2e67
PYTHON_TCOLORPY_SETUP_TYPE = setuptools
PYTHON_TCOLORPY_LICENSE = MIT
PYTHON_TCOLORPY_LICENSE_FILES = LICENSE

$(eval $(python-package))

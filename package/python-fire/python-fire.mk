################################################################################
#
# python-fire
#
################################################################################

PYTHON_FIRE_VERSION = 0.6.0
PYTHON_FIRE_SOURCE = fire-$(PYTHON_FIRE_VERSION).tar.gz
PYTHON_FIRE_SITE = https://files.pythonhosted.org/packages/1b/1b/84c63f592ecdfbb3d77d22a8d93c9b92791e4fa35677ad71a7d6449100f8
PYTHON_FIRE_SETUP_TYPE = setuptools
PYTHON_FIRE_LICENSE = Apache-2.0
PYTHON_FIRE_LICENSE_FILES = LICENSE

$(eval $(python-package))

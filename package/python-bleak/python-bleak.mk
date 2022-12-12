################################################################################
#
# python-bleak
#
################################################################################

PYTHON_BLEAK_VERSION = 0.19.5
PYTHON_BLEAK_SOURCE = bleak-$(PYTHON_BLEAK_VERSION).tar.gz
PYTHON_BLEAK_SITE = https://files.pythonhosted.org/packages/e6/b4/e63829826a157d180831a1c5d3720e75d613c1290cb239510d148b906836
PYTHON_BLEAK_SETUP_TYPE = setuptools
PYTHON_BLEAK_LICENSE = MIT
PYTHON_BLEAK_LICENSE_FILES = LICENSE

$(eval $(python-package))

################################################################################
#
# python-yarl
#
################################################################################

PYTHON_YARL_VERSION = 1.17.0
PYTHON_YARL_SOURCE = yarl-$(PYTHON_YARL_VERSION).tar.gz
PYTHON_YARL_SITE = https://files.pythonhosted.org/packages/55/8f/d2d546f8b674335fa7ef83cc5c1892294f3f516c570893e65a7ea8ed49c9
PYTHON_YARL_LICENSE = Apache-2.0
PYTHON_YARL_LICENSE_FILES = LICENSE
PYTHON_YARL_SETUP_TYPE = setuptools
PYTHON_YARL_DEPENDENCIES = \
	host-python-cython \
	host-python-expandvars

$(eval $(python-package))

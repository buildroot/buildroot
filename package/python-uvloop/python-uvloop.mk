################################################################################
#
# python-uvloop
#
################################################################################

PYTHON_UVLOOP_VERSION = 0.22.1
PYTHON_UVLOOP_SOURCE = uvloop-$(PYTHON_UVLOOP_VERSION).tar.gz
PYTHON_UVLOOP_SITE = https://files.pythonhosted.org/packages/06/f0/18d39dbd1971d6d62c4629cc7fa67f74821b0dc1f5a77af43719de7936a7
PYTHON_UVLOOP_SETUP_TYPE = setuptools
PYTHON_UVLOOP_LICENSE = Apache-2.0, MIT
PYTHON_UVLOOP_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
PYTHON_UVLOOP_DEPENDENCIES = libuv
PYTHON_UVLOOP_BUILD_OPTS = \
	--skip-dependency-check \
	-C--build-option=build_ext \
	-C--build-option=--inplace \
	-C--build-option=--use-system-libuv

$(eval $(python-package))

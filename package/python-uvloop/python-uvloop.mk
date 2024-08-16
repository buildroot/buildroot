################################################################################
#
# python-uvloop
#
################################################################################

PYTHON_UVLOOP_VERSION = 0.20.0
PYTHON_UVLOOP_SOURCE = uvloop-$(PYTHON_UVLOOP_VERSION).tar.gz
PYTHON_UVLOOP_SITE = https://files.pythonhosted.org/packages/bc/f1/dc9577455e011ad43d9379e836ee73f40b4f99c02946849a44f7ae64835e
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

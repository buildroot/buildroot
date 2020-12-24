################################################################################
#
# python-uvloop
#
################################################################################

PYTHON_UVLOOP_VERSION = 3810530
PYTHON_UVLOOP_SITE = $(call github,MagicStack,uvloop,$(PYTHON_UVLOOP_VERSION))
PYTHON_UVLOOP_SETUP_TYPE = setuptools
PYTHON_UVLOOP_LICENSE = Apache-2.0, MIT
PYTHON_UVLOOP_LICENSE_FILES = LICENSE-APACHE LICENSE-MIT
PYTHON_UVLOOP_BUILD_OPTS = build_ext --inplace --use-system-libuv
PYTHON_UVLOOP_INSTALL_TARGET_OPTS = build_ext --inplace --use-system-libuv
PYTHON_UVLOOP_DEPENDENCIES = libuv

$(eval $(python-package))

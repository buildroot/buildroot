################################################################################
#
# volk
#
################################################################################

VOLK_VERSION = 3.1.2
VOLK_SITE = https://github.com/gnuradio/volk/releases/download/v$(VOLK_VERSION)
VOLK_SOURCE = volk-$(VOLK_VERSION).tar.xz
VOLK_LICENSE = LGPL-3.0+
VOLK_LICENSE_FILES = COPYING

VOLK_SUPPORTS_IN_SOURCE_BUILD = NO

# host-python-mako are needed for volk to compile
VOLK_DEPENDENCIES = host-python3 host-python-mako

VOLK_CONF_OPTS = \
	-DPYTHON_EXECUTABLE=$(HOST_DIR)/bin/python3 \
	-DENABLE_MODTOOL=OFF \
	-DENABLE_TESTING=OFF \
	-DENABLE_PROFILING=OFF \
	-DVOLK_PYTHON_DIR=lib/python$(PYTHON3_VERSION_MAJOR)/site-packages

# For third-party blocks, the volk library is mandatory at
# compile time.
VOLK_INSTALL_STAGING = YES

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
VOLK_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

ifeq ($(BR2_PACKAGE_ORC),y)
VOLK_DEPENDENCIES += orc
VOLK_CONF_OPTS += -DENABLE_ORC=ON
else
VOLK_CONF_OPTS += -DENABLE_ORC=OFF
endif

$(eval $(cmake-package))

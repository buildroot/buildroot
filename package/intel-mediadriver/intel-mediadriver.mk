################################################################################
#
# intel-mediadriver
#
################################################################################

# based on https://software.intel.com/en-us/articles/build-and-debug-open-source-media-stack

INTEL_MEDIADRIVER_VERSION = 22.1.1
INTEL_MEDIADRIVER_SITE = http://github.com/intel/media-driver/archive
INTEL_MEDIADRIVER_SOURCE= intel-media-$(INTEL_MEDIADRIVER_VERSION).tar.gz
INTEL_MEDIADRIVER_LICENSE = MIT, BSD-3-Clause
INTEL_MEDIADRIVER_LICENSE_FILES = LICENSE.md

INTEL_MEDIADRIVER_DEPENDENCIES = \
	intel-gmmlib \
	libpciaccess \
	libva \
	mesa3d

ifeq ($(BR2_PACKAGE_XLIB_LIBX11),y)
INTEL_MEDIADRIVER_DEPENDENCIES += xlib_libX11
endif

INTEL_MEDIADRIVER_SUPPORTS_IN_SOURCE_BUILD = NO

# hardening is disabled here, so that the top-level Buildroot options
# control which hardening features are enabled
INTEL_MEDIADRIVER_CONF_OPTS = \
	-DINSTALL_DRIVER_SYSCONF=OFF \
	-DMEDIA_BUILD_FATAL_WARNINGS=OFF \
	-DMEDIA_RUN_TEST_SUITE=OFF \
	-DMEDIA_BUILD_HARDENING=OFF

ifeq ($(BR2_PACKAGE_INTEL_MEDIADRIVER_GEN8),y)
INTEL_MEDIADRIVER_CONF_OPTS += -DGEN8=ON
else
INTEL_MEDIADRIVER_CONF_OPTS += -DGEN8=OFF
endif

$(eval $(cmake-package))

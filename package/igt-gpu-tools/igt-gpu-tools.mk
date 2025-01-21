################################################################################
#
# igt-gpu-tools
#
################################################################################

IGT_GPU_TOOLS_VERSION = 0ee4074685c1e184f2d3612ea6eb4d126f9a2e23
IGT_GPU_TOOLS_SOURCE = igt-gpu-tools-$(IGT_GPU_TOOLS_VERSION).tar.bz2
IGT_GPU_TOOLS_SITE = https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/archive/$(IGT_GPU_TOOLS_VERSION)
IGT_GPU_TOOLS_LICENSE = MIT
IGT_GPU_TOOLS_LICENSE_FILES = COPYING
IGT_GPU_TOOLS_INSTALL_STAGING = YES
IGT_GPU_TOOLS_DEPENDENCIES = \
	host-pkgconf \
	cairo \
	elfutils \
	kmod \
	libdrm \
	libglib2 \
	libpciaccess \
	pixman \
	procps-ng \
	udev \
	zlib

IGT_GPU_TOOLS_CONF_OPTS = \
	-Dchamelium=disabled

ifeq ($(BR2_PACKAGE_IGT_GPU_TOOLS_TESTS),y)
IGT_GPU_TOOLS_CONF_OPTS += -Dtests=enabled
else
IGT_GPU_TOOLS_CONF_OPTS += -Dtests=disabled
endif

# On x86 systems, libigt resolves igt_half_to_float and igt_float_to_half as
# indirect functions at runtime by checking CPU features with igt_x86_features.
# The igt_x86_features function is implemented is a different object and the
# call uses the PLT itself. If lazy binding is disabled, this causes a segfault
# while resolving the symbols for libigt on x64 systems. Disable BINDNOW on X86
# systems to prevent the segfaults.
# https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/issues/102
# https://bugs.gentoo.org/788625#c13
ifeq ($(BR2_i386)$(BR2_x86_64)x$(BR2_RELRO_NONE),yx)
IGT_GPU_TOOLS_LDFLAGS = $(TARGET_LDFLAGS) -Wl,-z,lazy
endif

ifeq ($(BR2_PACKAGE_JSON_C),y)
IGT_GPU_TOOLS_CONF_OPTS += -Drunner=enabled
IGT_GPU_TOOLS_DEPENDENCIES += json-c
else
IGT_GPU_TOOLS_CONF_OPTS += -Drunner=disabled
endif

ifeq ($(BR2_PACKAGE_LIBUNWIND),y)
IGT_GPU_TOOLS_CONF_OPTS += -Dlibunwind=enabled
IGT_GPU_TOOLS_DEPENDENCIES += libunwind
else
IGT_GPU_TOOLS_CONF_OPTS += -Dlibunwind=disabled
endif

$(eval $(meson-package))

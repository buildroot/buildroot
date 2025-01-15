################################################################################
#
# libcamera
#
################################################################################

LIBCAMERA_SITE = https://git.linuxtv.org/libcamera.git
LIBCAMERA_VERSION = v0.4.0
LIBCAMERA_SITE_METHOD = git
LIBCAMERA_DEPENDENCIES = \
	host-openssl \
	host-pkgconf \
	host-python-jinja2 \
	host-python-ply \
	host-python-pyyaml \
	libyaml \
	gnutls
LIBCAMERA_CONF_OPTS = \
	-Dandroid=disabled \
	-Ddocumentation=disabled \
	-Dtest=false \
	-Dwerror=false
LIBCAMERA_INSTALL_STAGING = YES
LIBCAMERA_LICENSE = \
	LGPL-2.1+ (library), \
	GPL-2.0+ (utils), \
	MIT (qcam/assets/feathericons), \
	BSD-2-Clause (raspberrypi), \
	GPL-2.0 with Linux-syscall-note or BSD-3-Clause (linux kernel headers), \
	CC0-1.0 (meson build system), \
	CC-BY-SA-4.0 (doc)
LIBCAMERA_LICENSE_FILES = \
	LICENSES/LGPL-2.1-or-later.txt \
	LICENSES/GPL-2.0-or-later.txt \
	LICENSES/MIT.txt \
	LICENSES/BSD-2-Clause.txt \
	LICENSES/GPL-2.0-only.txt \
	LICENSES/Linux-syscall-note.txt \
	LICENSES/BSD-3-Clause.txt \
	LICENSES/CC0-1.0.txt \
	LICENSES/CC-BY-SA-4.0.txt

ifeq ($(BR2_TOOLCHAIN_GCC_AT_LEAST_7),y)
LIBCAMERA_CXXFLAGS = -faligned-new
endif

ifeq ($(BR2_PACKAGE_LIBCAMERA_PYTHON),y)
LIBCAMERA_DEPENDENCIES += python3 python-pybind
LIBCAMERA_CONF_OPTS += -Dpycamera=enabled
else
LIBCAMERA_CONF_OPTS += -Dpycamera=disabled
endif

ifeq ($(BR2_PACKAGE_LIBCAMERA_V4L2),y)
LIBCAMERA_CONF_OPTS += -Dv4l2=true
else
LIBCAMERA_CONF_OPTS += -Dv4l2=false
endif

LIBCAMERA_PIPELINES-$(BR2_PACKAGE_LIBCAMERA_PIPELINE_IMX8_ISI) += imx8-isi
LIBCAMERA_PIPELINES-$(BR2_PACKAGE_LIBCAMERA_PIPELINE_IPU3) += ipu3
LIBCAMERA_PIPELINES-$(BR2_PACKAGE_LIBCAMERA_PIPELINE_RKISP1) += rkisp1
ifeq ($(BR2_PACKAGE_LIBCAMERA_PIPELINE_RPI_VC4),y)
LIBCAMERA_PIPELINES-y += rpi/vc4
LIBCAMERA_DEPENDENCIES += boost
endif
LIBCAMERA_PIPELINES-$(BR2_PACKAGE_LIBCAMERA_PIPELINE_SIMPLE) += simple
LIBCAMERA_PIPELINES-$(BR2_PACKAGE_LIBCAMERA_PIPELINE_UVCVIDEO) += uvcvideo
LIBCAMERA_PIPELINES-$(BR2_PACKAGE_LIBCAMERA_PIPELINE_VIMC) += vimc

LIBCAMERA_CONF_OPTS += -Dpipelines=$(subst $(space),$(comma),$(LIBCAMERA_PIPELINES-y))

ifeq ($(BR2_PACKAGE_LIBCAMERA_COMPLIANCE),y)
LIBCAMERA_DEPENDENCIES += gtest libevent
LIBCAMERA_CONF_OPTS += -Dlc-compliance=enabled
else
LIBCAMERA_CONF_OPTS += -Dlc-compliance=disabled
endif

# gstreamer-video-1.0, gstreamer-allocators-1.0
ifeq ($(BR2_PACKAGE_GSTREAMER1)$(BR2_PACKAGE_GST1_PLUGINS_BASE),yy)
LIBCAMERA_CONF_OPTS += -Dgstreamer=enabled
LIBCAMERA_DEPENDENCIES += gstreamer1 gst1-plugins-base
endif

ifeq ($(BR2_PACKAGE_QT5BASE_WIDGETS),y)
LIBCAMERA_CONF_OPTS += -Dqcam=enabled
LIBCAMERA_DEPENDENCIES += qt5base
ifeq ($(BR2_PACKAGE_QT5TOOLS_LINGUIST_TOOLS),y)
LIBCAMERA_DEPENDENCIES += qt5tools
endif
else
LIBCAMERA_CONF_OPTS += -Dqcam=disabled
endif

ifeq ($(BR2_PACKAGE_LIBEVENT),y)
LIBCAMERA_CONF_OPTS += -Dcam=enabled
LIBCAMERA_DEPENDENCIES += libevent
else
LIBCAMERA_CONF_OPTS += -Dcam=disabled
endif

ifeq ($(BR2_PACKAGE_TIFF),y)
LIBCAMERA_DEPENDENCIES += tiff
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
LIBCAMERA_CONF_OPTS += -Dudev=enabled
LIBCAMERA_DEPENDENCIES += udev
else
LIBCAMERA_CONF_OPTS += -Dudev=disabled
endif

ifeq ($(BR2_PACKAGE_LTTNG_LIBUST),y)
LIBCAMERA_CONF_OPTS += -Dtracing=enabled
LIBCAMERA_DEPENDENCIES += lttng-libust
else
LIBCAMERA_CONF_OPTS += -Dtracing=disabled
endif

ifeq ($(BR2_PACKAGE_LIBEXECINFO),y)
LIBCAMERA_DEPENDENCIES += libexecinfo
LIBCAMERA_LDFLAGS = $(TARGET_LDFLAGS) -lexecinfo
endif

# Open-Source IPA shlibs need to be signed in order to be runnable within the
# same process, otherwise they are deemed Closed-Source and run in another
# process and communicate over IPC.
# Buildroot sanitizes RPATH in a post build process. meson gets rid of rpath
# while installing so we don't need to do it manually here.
# Buildroot may strip symbols, so we need to do the same before signing
# otherwise the signature won't match the shlib on the rootfs. Since meson
# install target is signing the shlibs, we need to strip them before.
LIBCAMERA_STRIP_FIND_CMD = \
	find $(@D)/build/src/ipa \
	$(if $(call qstrip,$(BR2_STRIP_EXCLUDE_FILES)), \
		-not \( $(call findfileclauses,$(call qstrip,$(BR2_STRIP_EXCLUDE_FILES))) \) ) \
	-type f -name 'ipa_*.so' -print0

define LIBCAMERA_BUILD_STRIP_IPA_SO
	$(LIBCAMERA_STRIP_FIND_CMD) | xargs --no-run-if-empty -0 $(STRIPCMD)
endef

LIBCAMERA_POST_BUILD_HOOKS += LIBCAMERA_BUILD_STRIP_IPA_SO

$(eval $(meson-package))

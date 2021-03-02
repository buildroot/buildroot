################################################################################
#
# gst1-interpipe
#
################################################################################

GST1_INTERPIPE_VERSION = 9af5b40d106f35ce75f8baa5efc8c59fc5f7eda1
GST1_INTERPIPE_SITE = https://github.com/RidgeRun/gst-interpipe
GST1_INTERPIPE_SITE_METHOD = git
# fetch gst-interpipe/common sub module
GST1_INTERPIPE_GIT_SUBMODULES = YES

GST1_INTERPIPE_LICENSE = LGPL-2.1
GST1_INTERPIPE_LICENSE_FILES = COPYING

# from git source
GST1_INTERPIPE_AUTORECONF = YES

GST1_INTERPIPE_DEPENDENCIES = host-pkgconf gstreamer1 gst1-plugins-base

GST1_INTERPIPE_CFLAGS = $(TARGET_CFLAGS) $(GSTREAMER1_EXTRA_COMPILER_OPTIONS)

$(eval $(autotools-package))

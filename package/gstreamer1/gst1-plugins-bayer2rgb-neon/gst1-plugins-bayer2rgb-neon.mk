################################################################################
#
# gst1-plugins-bayer2rgb-neon
#
################################################################################

GST1_PLUGINS_BAYER2RGB_NEON_VERSION = v0.6.0-11-g7e06aa310805b1600d12f1d3bb0058aa02ab8f83
GST1_PLUGINS_BAYER2RGB_NEON_SITE = https://gitlab-ext.sigma-chemnitz.de/ensc/gst-bayer2rgb-neon.git
GST1_PLUGINS_BAYER2RGB_NEON_SITE_METHOD = git
GST1_PLUGINS_BAYER2RGB_NEON_LICENSE = GPL-3.0
GST1_PLUGINS_BAYER2RGB_NEON_LICENSE_FILES = COPYING

GST1_PLUGINS_BAYER2RGB_NEON_DEPENDENCIES = \
	host-pkgconf \
	gstreamer1 \
	gst1-plugins-base \
	bayer2rgb-neon

GST1_PLUGINS_BAYER2RGB_NEON_AUTORECONF = YES

GST1_PLUGINS_BAYER2RGB_NEON_CONF_OPTS = --with-plugindir=/usr/lib/gstreamer-1.0

$(eval $(autotools-package))

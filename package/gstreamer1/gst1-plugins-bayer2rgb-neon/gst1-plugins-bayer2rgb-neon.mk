################################################################################
#
# gst1-plugins-bayer2rgb-neon
#
################################################################################

GST1_PLUGINS_BAYER2RGB_NEON_VERSION = b630798efcd611879e7cb1c246052e5ba1acc41d
GST1_PLUGINS_BAYER2RGB_NEON_SITE = https://gitlab-ext.sigma-chemnitz.de/ensc/gst-bayer2rgb-neon.git
GST1_PLUGINS_BAYER2RGB_NEON_SITE_METHOD = git
GST1_PLUGINS_BAYER2RGB_NEON_LICENSE = GPL-3.0
GST1_PLUGINS_BAYER2RGB_NEON_LICENSE_FILES = COPYING

GST1_PLUGINS_BAYER2RGB_NEON_INSTALL_STAGING = YES

GST1_PLUGINS_BAYER2RGB_NEON_DEPENDENCIES = \
	host-pkgconf \
	gstreamer1 \
	gst1-plugins-base \
	bayer2rgb-neon

GST1_PLUGINS_BAYER2RGB_NEON_AUTORECONF = YES

$(eval $(autotools-package))

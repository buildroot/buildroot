################################################################################
#
# sc2mpd
#
################################################################################

SC2MPD_VERSION = 7dd8f99f0361d6a65de94ae4df4f75846be977f6
SC2MPD_SITE = git@github.com:medoc92/sc2mpd.git
SC2MPD_SITE_METHOD = git
SC2MPD_LICENSE = GPLv2+
SC2MPD_LICENSE_FILES = COPYING
SC2MPD_DEPENDENCIES = alsa-lib libmicrohttpd libsamplerate \
	ohnet ohnetgenerated ohsongcast
SC2MPD_AUTORECONF = YES

SC2MPD_CONF_ENV = \
	CPPFLAGS="$(TARGET_CPPFLAGS) -DDEFINE_$(call qstrip,$(BR2_ENDIAN))_ENDIAN"

SC2MPD_CONF_OPTS = \
	--with-ohnet=$(STAGING_DIR)/usr \
	--with-ohnetgenerated=$(STAGING_DIR)/usr \
	--with-ohsongcast=$(STAGING_DIR)/usr

$(eval $(autotools-package))

################################################################################
#
# libsndfile
#
################################################################################

LIBSNDFILE_VERSION = 1.2.2
LIBSNDFILE_SOURCE = libsndfile-$(LIBSNDFILE_VERSION).tar.xz
LIBSNDFILE_SITE = https://github.com/libsndfile/libsndfile/releases/download/$(LIBSNDFILE_VERSION)
LIBSNDFILE_INSTALL_STAGING = YES
LIBSNDFILE_LICENSE = LGPL-2.1+
LIBSNDFILE_LICENSE_FILES = COPYING
LIBSNDFILE_CPE_ID_VALID = YES
LIBSNDFILE_DEPENDENCIES = host-pkgconf

# 0001-mat4-mat5-fix-int-overflow-in-dataend-calculation.patch
# 0002-au-avoid-int-overflow-while-calculating-data_end.patch
# 0003-avr-fix-int-overflow-in-avr_read_header.patch
# 0004-sds-fix-int-overflow-warning-in-sample-calculations.patch
# 0005-aiff-fix-int-overflow-when-counting-header-elements.patch
# 0006-ircam-fix-int-overflow-in-ircam_read_header.patch
# 0007-mat4-mat5-fix-int-overflow-when-calculating-blockwid.patch
# 0008-common-fix-int-overflow-in-psf_binheader_readf.patch
# 0009-nms_adpcm-fix-int-overflow-in-signal-estimate.patch
# 0010-nms_adpcm-fix-int-overflow-in-sf.frames-calc.patch
# 0011-pcm-fix-int-overflow-in-pcm_init.patch
# 0012-rf64-fix-int-overflow-in-rf64_read_header.patch
# 0013-ima_adpcm-fix-int-overflow-in-ima_reader_init.patch
LIBSNDFILE_IGNORE_CVES += CVE-2022-33065

# 0014-src-ogg-better-error-checking-for-vorbis.-Fixes-1035.patch
LIBSNDFILE_IGNORE_CVES += CVE-2024-50612

LIBSNDFILE_CONF_ENV = ac_cv_prog_cc_c99='-std=gnu99'
LIBSNDFILE_CONF_OPTS = \
	--disable-sqlite \
	--disable-alsa \
	--disable-full-suite

ifeq ($(BR2_PACKAGE_FLAC)$(BR2_PACKAGE_LIBVORBIS)$(BR2_PACKAGE_OPUS),yyy)
LIBSNDFILE_DEPENDENCIES += flac host-pkgconf libvorbis opus
LIBSNDFILE_CONF_OPTS += --enable-external-libs
else
LIBSNDFILE_CONF_OPTS += --disable-external-libs
endif

$(eval $(autotools-package))

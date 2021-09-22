################################################################################
#
# libsndfile
#
################################################################################

LIBSNDFILE_VERSION = 1.0.31
LIBSNDFILE_SOURCE = libsndfile-$(LIBSNDFILE_VERSION).tar.bz2
LIBSNDFILE_SITE = https://github.com/libsndfile/libsndfile/releases/download/$(LIBSNDFILE_VERSION)
LIBSNDFILE_INSTALL_STAGING = YES
LIBSNDFILE_LICENSE = LGPL-2.1+
LIBSNDFILE_LICENSE_FILES = COPYING
LIBSNDFILE_CPE_ID_VENDOR = libsndfile_project

# 0001-ms_adpcm-Fix-and-extend-size-checks.patch
LIBSNDFILE_IGNORE_CVES += CVE-2021-3246

# disputed, https://github.com/erikd/libsndfile/issues/398
LIBSNDFILE_IGNORE_CVES += CVE-2018-13419

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

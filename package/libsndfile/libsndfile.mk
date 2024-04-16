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

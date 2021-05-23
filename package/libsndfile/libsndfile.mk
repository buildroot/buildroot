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

# disputed, https://github.com/erikd/libsndfile/issues/398
LIBSNDFILE_IGNORE_CVES += CVE-2018-13419

LIBSNDFILE_CONF_OPTS = \
	--disable-sqlite \
	--disable-alsa \
	--disable-external-libs \
	--disable-full-suite

$(eval $(autotools-package))

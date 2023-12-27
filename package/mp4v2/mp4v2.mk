################################################################################
#
# mp4v2
#
################################################################################

MP4V2_VERSION = 2.1.3
MP4V2_SITE = \
	https://github.com/enzo1982/mp4v2/releases/download/v$(MP4V2_VERSION)
MP4V2_SOURCE = mp4v2-$(MP4V2_VERSION).tar.bz2
MP4V2_INSTALL_STAGING = YES
MP4V2_LICENSE = MPL-1.1
MP4V2_LICENSE_FILES = COPYING

# help2man expects to be able to run utilities on the build machine to
# grab --help output which doesn't work when cross compiling, so
# disable it
MP4V2_CONF_ENV = ac_cv_prog_FOUND_HELP2MAN=no

ifeq ($(BR2_PACKAGE_MP4V2_UTIL),y)
MP4V2_CONF_OPTS += --enable-util
else
MP4V2_CONF_OPTS += --disable-util
endif

$(eval $(autotools-package))

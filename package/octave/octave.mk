################################################################################
#
# octave
#
################################################################################

OCTAVE_VERSION = 7.3.0
OCTAVE_SITE = https://ftp.gnu.org/gnu/octave
OCTAVE_SOURCE = octave-$(OCTAVE_VERSION).tar.lz
OCTAVE_LICENSE = GPL-3.0+
OCTAVE_LICENSE_FILES = COPYING
OCTAVE_AUTORECONF = YES

OCTAVE_CONF_OPTS = --disable-java

OCTAVE_DEPENDENCIES = \
	host-gperf \
	openblas \
	pcre

ifeq ($(BR2_PACKAGE_READLINE),y)
OCTAVE_CONF_OPTS += --enable-readline
OCTAVE_DEPENDENCIES += readline
else
OCTAVE_CONF_OPTS += --disable-readline
endif

$(eval $(autotools-package))

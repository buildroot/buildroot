#############################################################
#
# libmikmod
#
#############################################################
LIBMIKMOD_VERSION := 3.3.11.1
LIBMIKMOD_SITE := https://sourceforge.net/projects/mikmod/files/libmikmod/${LIBMIKMOD_VERSION}
LIBMIKMOD_INSTALL_STAGING = YES

LIBMIKMOD_CONF_OPTS = --localstatedir=/var --disable-esd

$(eval $(autotools-package))

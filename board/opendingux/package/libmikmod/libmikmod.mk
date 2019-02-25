#############################################################
#
# libmikmod
#
#############################################################
LIBMIKMOD_VERSION := 3.3.11.1
LIBMIKMOD_SITE:=http://sourceforge.net/projects/mikmod/files
LIBMIKMOD_INSTALL_STAGING = YES

LIBMIKMOD_CONF_OPTS = --localstatedir=/var --disable-esd

$(eval $(autotools-package))

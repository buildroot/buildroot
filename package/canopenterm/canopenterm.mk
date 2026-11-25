################################################################################
#
# canopenterm
#
################################################################################

CANOPENTERM_VERSION = 2.04
CANOPENTERM_SITE = $(call github,CANopenTerm,CANopenTerm,v$(CANOPENTERM_VERSION))
CANOPENTERM_LICENSE = MIT
CANOPENTERM_LICENSE_FILES = LICENSE.md
CANOPENTERM_DEPENDENCIES = \
	canvenient \
	cjson \
	inih \
	isocline \
	lua \
	pocketpy \
	readline \
	sdl3

CANOPENTERM_CONF_OPTS = -DUSE_SYSTEM_LIBS=ON

$(eval $(cmake-package))

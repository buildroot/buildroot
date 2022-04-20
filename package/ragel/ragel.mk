################################################################################
#
# ragel
#
################################################################################

RAGEL_VERSION = 6.10
RAGEL_SITE = https://www.colm.net/files/ragel/
RAGEL_LICENSE = GPL-2.0
RAGEL_LICENSE_FILES = COPYING
RAGEL_CONF_OPTS = \
	--disable-silent-rules \
	--disable-manual \
	--disable-dependency-tracking

$(eval $(host-autotools-package))

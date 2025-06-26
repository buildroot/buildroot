################################################################################
#
# gumbo-parser
#
################################################################################

GUMBO_PARSER_VERSION = 0.13.1
GUMBO_PARSER_SITE = https://codeberg.org/gumbo-parser/gumbo-parser/archive
GUMBO_PARSER_SOURCE = $(GUMBO_PARSER_VERSION).tar.gz
GUMBO_PARSER_LICENSE = Apache-2.0
GUMBO_PARSER_LICENSE_FILES = doc/COPYING
GUMBO_PARSER_INSTALL_STAGING = YES
GUMBO_PARSER_AUTORECONF = YES
GUMBO_PARSER_CONF_OPTS = --disable-examples

$(eval $(autotools-package))

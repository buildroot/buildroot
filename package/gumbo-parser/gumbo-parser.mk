################################################################################
#
# gumbo-parser
#
################################################################################

GUMBO_PARSER_VERSION = 0.10.1
GUMBO_PARSER_SITE = $(call github,google,gumbo-parser,v$(GUMBO_PARSER_VERSION))
GUMBO_PARSER_LICENSE = Apache-2.0
GUMBO_PARSER_LICENSE_FILES = COPYING
GUMBO_PARSER_INSTALL_STAGING = YES
GUMBO_PARSER_AUTORECONF = YES
GUMBO_PARSER_CONF_OPTS = --disable-examples

$(eval $(autotools-package))

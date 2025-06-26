################################################################################
#
# gumbo-parser-test
#
################################################################################

GUMBO_PARSER_TEST_DEPENDENCIES = gumbo-parser

define GUMBO_PARSER_TEST_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) -o $(@D)/gumbo_test \
		$(GUMBO_PARSER_TEST_PKGDIR)/gumbo_test.c \
		$(TARGET_LDFLAGS) -lgumbo
endef

define GUMBO_PARSER_TEST_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/gumbo_test $(TARGET_DIR)/usr/bin/gumbo_test
endef

$(eval $(generic-package))

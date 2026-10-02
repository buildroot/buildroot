################################################################################
#
# sqlitecpp-test
#
################################################################################

SQLITECPP_TEST_DEPENDENCIES = sqlitecpp

define SQLITECPP_TEST_BUILD_CMDS
	$(TARGET_CXX) $(TARGET_CXXFLAGS) -o $(@D)/sqlitecpp-test \
		$(SQLITECPP_TEST_PKGDIR)/sqlitecpp-test.cpp \
		$(TARGET_LDFLAGS) -lSQLiteCpp -lsqlite3
endef

define SQLITECPP_TEST_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/sqlitecpp-test $(TARGET_DIR)/usr/bin/sqlitecpp-test
endef

$(eval $(generic-package))

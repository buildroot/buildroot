################################################################################
#
# SQLiteC++
#
################################################################################

SQLITECPP_VERSION = 3.4.0
SQLITECPP_SITE = $(call github,SRombauts,SQLiteCpp,$(SQLITECPP_VERSION))
SQLITECPP_LICENSE = MIT
SQLITECPP_LICENSE_FILES = LICENSE.txt
SQLITECPP_DEPENDENCIES = sqlite
SQLITECPP_INSTALL_STAGING = YES

SQLITECPP_CONF_OPTS = \
	-DSQLITECPP_INTERNAL_SQLITE=OFF \
	-DSQLITECPP_RUN_CPPLINT=OFF \
	-DSQLITECPP_RUN_CPPCHECK=OFF \
	-DSQLITECPP_USE_STACK_PROTECTION=OFF

$(eval $(cmake-package))

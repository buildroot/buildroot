################################################################################
#
# fmt
#
################################################################################

FMT_VERSION = 3.0.1
FMT_SITE = git@github.com:fmtlib/fmt.git
FMT_SITE_METHOD = git
FMT_LICENSE = GPLv2
FMT_LICENSE_FILES = COPYING
FMT_DEPENDENCIES = host-cmake
FMT_INSTALL_STAGING = YES
FMT_INSTALL_TARGET = NO

FMT_CONF_OPTS += -DBUILD_SHARED_LIBS=ON
FMT_CONF_OPTS += -DHAVE_OPEN=ON
FMT_CONF_OPTS += -DFMT_INSTALL=ON
FMT_CONF_OPTS += -DFMT_TEST=OFF

define FMT_INSTALL_STAGING_CMDS
	rm -rf $(STAGING_DIR)/usr/include/fmt
	mkdir -p $(STAGING_DIR)/usr/include/fmt
	$(INSTALL) -D $(@D)/fmt/*.h $(STAGING_DIR)/usr/include/fmt
	$(INSTALL) -D $(@D)/fmt/*.cc $(STAGING_DIR)/usr/include/fmt
endef

$(eval $(cmake-package))

################################################################################
#
# re2
#
################################################################################

RE2_VERSION = 2022-12-01
RE2_SITE = $(call github,google,re2,$(RE2_VERSION))
RE2_LICENSE = BSD-3-Clause
RE2_LICENSE_FILES = LICENSE
RE2_INSTALL_STAGING = YES

RE2_MAKE_OPTS = \
	$(TARGET_CONFIGURE_OPTS) \
	CXXFLAGS="$(TARGET_CXXFLAGS) -std=c++11"

define RE2_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(RE2_MAKE_OPTS) \
		-C $(@D) $(if $(BR2_STATIC_LIBS),static)
endef

define RE2_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(RE2_MAKE_OPTS) \
		DESTDIR="$(STAGING_DIR)" prefix=/usr -C $(@D) \
		$(if $(BR2_STATIC_LIBS),static-install,install)
endef

define RE2_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(RE2_MAKE_OPTS) \
		DESTDIR="$(TARGET_DIR)" prefix=/usr -C $(@D) \
		$(if $(BR2_STATIC_LIBS),static-install,install)
endef

define HOST_RE2_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_CONFIGURE_OPTS) \
		-C $(@D)
endef

define HOST_RE2_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_CONFIGURE_OPTS) \
		-C $(@D) DESTDIR="$(HOST_DIR)" prefix=/usr install
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

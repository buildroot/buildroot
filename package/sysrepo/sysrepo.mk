################################################################################
#
# sysrepo
#
################################################################################

SYSREPO_VERSION = 2.1.42
SYSREPO_SITE = $(call github,sysrepo,sysrepo,v$(SYSREPO_VERSION))
SYSREPO_INSTALL_STAGING = YES
SYSREPO_LICENSE = BSD-3-Clause
SYSREPO_LICENSE_FILES = LICENSE
SYSREPO_DEPENDENCIES = libyang pcre2 host-sysrepo
HOST_SYSREPO_DEPENDENCIES = host-libyang host-pcre2

ifeq ($(BR2_INIT_SYSTEMD),y)
SYSREPO_DEPENDENCIES += systemd
endif

SYSREPO_CONF_OPTS = \
	-DBUILD_EXAMPLES=$(if $(BR2_PACKAGE_SYSREPO_EXAMPLES),ON,OFF) \
	-DENABLE_TESTS=OFF \
	-DENABLE_VALGRIND_TESTS=OFF \
	-DREPO_PATH=/etc/sysrepo

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
SYSREPO_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

define SYSREPO_INSTALL_INIT_SYSV
	$(INSTALL) -m 755 -D package/sysrepo/S51sysrepo-plugind \
		$(TARGET_DIR)/etc/init.d/S51sysrepo-plugind
endef

HOST_SYSREPO_CONF_OPTS = \
	-DBUILD_EXAMPLES=OFF \
	-DENABLE_TESTS=OFF \
	-DENABLE_VALGRIND_TESTS=OFF \
	-DREPO_PATH=$(TARGET_DIR)/etc/sysrepo

$(eval $(cmake-package))
$(eval $(host-cmake-package))

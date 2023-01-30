################################################################################
#
# fluent-bit
#
################################################################################

FLUENT_BIT_VERSION = 2.0.8
FLUENT_BIT_SITE = $(call github,fluent,fluent-bit,v$(FLUENT_BIT_VERSION))
FLUENT_BIT_LICENSE = Apache-2.0
FLUENT_BIT_LICENSE_FILES = LICENSE
FLUENT_BIT_DEPENDENCIES = host-bison host-flex libyaml libopenssl

FLUENT_BIT_CONF_OPTS += \
	-DFLB_DEBUG=No \
	-DFLB_RELEASE=Yes \
	-DFLB_EXAMPLES=No \
	-DFLB_CHUNK_TRACE=No \
	-DFLB_BACKTRACE=No

ifeq ($(BR2_PACKAGE_FLUENT_BIT_WASM),y)
FLUENT_BIT_CONF_OPTS += -DFLB_WASM=Yes
else
FLUENT_BIT_CONF_OPTS += -DFLB_WASM=No
endif

ifeq ($(BR2_PACKAGE_LUAJIT),y)
FLUENT_BIT_CONF_OPTS += -DFLB_LUAJIT=Yes
FLUENT_BIT_DEPENDENCIES += luajit
else
FLUENT_BIT_CONF_OPTS += -DFLB_LUAJIT=No
endif

# Force bundled miniz to be linked statically.
# https://github.com/fluent/fluent-bit/issues/6711
FLUENT_BIT_CONF_OPTS += \
	-DBUILD_SHARED_LIBS=OFF

# Move the config files from /usr/etc/ to /etc/.
# https://github.com/fluent/fluent-bit/issues/6619
FLUENT_BIT_CONF_OPTS += \
	-DCMAKE_INSTALL_SYSCONFDIR="/etc/"

# Undefining _FILE_OFFSET_BITS here because of a "bug" with glibc fts.h
# large file support.
# See https://bugzilla.redhat.com/show_bug.cgi?id=574992 for more information.
FLUENT_BIT_CONF_OPTS += \
	-DCMAKE_C_FLAGS="$(TARGET_CFLAGS) -U_FILE_OFFSET_BITS" \
	-DCMAKE_CXX_FLAGS="$(TARGET_CXXFLAGS) -U_FILE_OFFSET_BITS"

# Uses __atomic_compare_exchange_8
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
FLUENT_BIT_CONF_OPTS += \
	-DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

define FLUENT_BIT_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/fluent-bit/S99fluent-bit \
		$(TARGET_DIR)/etc/init.d/S99fluent-bit
endef

$(eval $(cmake-package))

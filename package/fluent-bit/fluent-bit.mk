################################################################################
#
# fluent-bit
#
################################################################################

FLUENT_BIT_VERSION = 2.0.9
FLUENT_BIT_SITE = $(call github,fluent,fluent-bit,v$(FLUENT_BIT_VERSION))
FLUENT_BIT_LICENSE = Apache-2.0
FLUENT_BIT_LICENSE_FILES = LICENSE
FLUENT_BIT_CPE_ID_VENDOR = treasuredata
FLUENT_BIT_CPE_ID_PRODUCT = fluent_bit
FLUENT_BIT_DEPENDENCIES = host-bison host-flex libyaml openssl

FLUENT_BIT_CFLAGS = $(TARGET_CFLAGS)
FLUENT_BIT_CXXFLAGS = $(TARGET_CXXFLAGS)

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

# Fix multiple definition of `mk_tls_*'.
# https://github.com/fluent/fluent-bit/issues/5537
FLUENT_BIT_CFLAGS += -fcommon
FLUENT_BIT_CXXFLAGS += -fcommon

# Undefining _FILE_OFFSET_BITS here because of a "bug" with glibc fts.h
# large file support.
# https://bugzilla.redhat.com/show_bug.cgi?id=574992
FLUENT_BIT_CFLAGS += -U_FILE_OFFSET_BITS
FLUENT_BIT_CXXFLAGS += -U_FILE_OFFSET_BITS

ifeq ($(BR2_TOOLCHAIN_USES_GLIBC),)
FLUENT_BIT_DEPENDENCIES += musl-fts
FLUENT_BIT_LDFLAGS += -lfts
endif

# Uses __atomic_compare_exchange_8
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
FLUENT_BIT_LDFLAGS += -latomic
endif

FLUENT_BIT_CONF_OPTS += \
	-DCMAKE_EXE_LINKER_FLAGS="$(FLUENT_BIT_LDFLAGS)" \
	-DCMAKE_C_FLAGS="$(FLUENT_BIT_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(FLUENT_BIT_CXXFLAGS)"

define FLUENT_BIT_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/fluent-bit/S99fluent-bit \
		$(TARGET_DIR)/etc/init.d/S99fluent-bit
endef

$(eval $(cmake-package))

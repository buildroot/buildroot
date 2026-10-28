################################################################################
#
# mender
#
################################################################################

MENDER_VERSION = 5.2.0
MENDER_SITE = https://github.com/mendersoftware/mender/releases/download/$(MENDER_VERSION)
MENDER_LICENSE = Apache-2.0, BSL-1.0, BSD-3-Clause, CC0-1.0, MIT, Unlicense
MENDER_CPE_ID_VENDOR = northern.tech

# Vendor license paths generated with:
#    awk '{print $2}' LIC_FILES_CHKSUM.sha256 | grep vendor
MENDER_LICENSE_FILES = \
	LICENSE \
	LIC_FILES_CHKSUM.sha256 \
	src/common/vendor/json/LICENSE.MIT \
	src/common/vendor/json/docs/mkdocs/docs/home/license.md \
	src/common/vendor/tiny-process-library/LICENSE \
	src/common/vendor/yaml-cpp/LICENSE \
	src/common/vendor/lmdbxx/UNLICENSE \
	src/common/vendor/expected/COPYING \
	src/common/vendor/optional-lite/LICENSE.txt \
	src/common/vendor/yaml-cpp/test/googletest-1.16.0/LICENSE

MENDER_DEPENDENCIES += \
	host-pkgconf \
	boost \
	dbus \
	libarchive \
	libglib2 \
	lmdb \
	openssl \
	systemd

MENDER_INSTALL_TARGET_OPTS = \
	install-bin \
	install-dbus \
	install-dbus-service-files \
	install-identity-scripts \
	install-inventory-network-scripts \
	install-inventory-scripts \
	install-modules \
	install-rootfs-image-module \
	install-systemd

define MENDER_INSTALL_CONFIG_FILES
	$(INSTALL) -D -m 0644 $(MENDER_PKGDIR)/mender.conf \
		$(TARGET_DIR)/etc/mender/mender.conf

	$(INSTALL) -D -m 0644 $(@D)/support/demo.crt \
		$(TARGET_DIR)/etc/mender/server.crt

	$(INSTALL) -D -m 0755 $(MENDER_PKGDIR)/device_type \
			$(TARGET_DIR)/etc/mender/device_type

	mkdir -p $(TARGET_DIR)/var/lib
endef
MENDER_POST_INSTALL_TARGET_HOOKS += MENDER_INSTALL_CONFIG_FILES

# The vendored tiny-process-library and yaml-cpp are built as part of
# mender but never installed, so always link them statically.
MENDER_CONF_OPTS += \
	-DBUILD_SHARED_LIBS=OFF \
	-DMENDER_EMBED_MENDER_AUTH=OFF \
	-DMENDER_USE_DBUS=ON \
	-DMENDER_VERSION=$(MENDER_VERSION)

ifeq ($(BR2_PACKAGE_GZIP),y)
MENDER_DEPENDENCIES += gzip
MENDER_CONF_OPTS += -DMENDER_ARTIFACT_GZIP_COMPRESSION=ON
else
MENDER_CONF_OPTS += -DMENDER_ARTIFACT_GZIP_COMPRESSION=OFF
endif

ifeq ($(BR2_PACKAGE_XZ),y)
MENDER_DEPENDENCIES += xz
MENDER_CONF_OPTS += -DMENDER_ARTIFACT_LZMA_COMPRESSION=ON
else
MENDER_CONF_OPTS += -DMENDER_ARTIFACT_LZMA_COMPRESSION=OFF
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
MENDER_DEPENDENCIES += zstd
MENDER_CONF_OPTS += -DMENDER_ARTIFACT_ZSTD_COMPRESSION=ON
else
MENDER_CONF_OPTS += -DMENDER_ARTIFACT_ZSTD_COMPRESSION=OFF
endif

define MENDER_INSTALL_MODULES_GEN
	$(MAKE) -C $(@D) DESTDIR=$(HOST_DIR) install-modules-gen
endef
MENDER_POST_INSTALL_TARGET_HOOKS += MENDER_INSTALL_MODULES_GEN

define MENDER_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) $(MENDER_INSTALL_TARGET_OPTS)
endef

# Needed for rootfs-image-module
define  MENDER_BUSYBOX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_FLOCK)
	$(call KCONFIG_ENABLE_OPT,CONFIG_STAT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_FEATURE_STAT_FORMAT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_FEATURE_SYNC_FANCY)
	$(call KCONFIG_ENABLE_OPT,CONFIG_WGET)
	$(call KCONFIG_ENABLE_OPT,CONFIG_FEATURE_WGET_HTTPS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_FEATURE_WGET_OPENSSL)
endef

$(eval $(cmake-package))

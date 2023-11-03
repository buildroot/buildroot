################################################################################
#
# mender
#
################################################################################

MENDER_VERSION = 3.4.0
MENDER_SITE = $(call github,mendersoftware,mender,$(MENDER_VERSION))
MENDER_LICENSE = Apache-2.0, BSD-2-Clause, BSD-3-Clause, ISC, MIT, OLDAP-2.8
MENDER_CPE_ID_VENDOR = northern.tech

# Vendor license paths generated with:
#    awk '{print $2}' LIC_FILES_CHKSUM.sha256 | grep vendor
MENDER_LICENSE_FILES = \
	LICENSE \
	LIC_FILES_CHKSUM.sha256 \
	vendor/github.com/mendersoftware/mender-artifact/LICENSE \
	vendor/github.com/mendersoftware/openssl/LICENSE \
	vendor/github.com/minio/sha256-simd/LICENSE \
	vendor/github.com/mendersoftware/progressbar/LICENSE \
	vendor/github.com/pkg/errors/LICENSE \
	vendor/github.com/godbus/dbus/LICENSE \
	vendor/github.com/gorilla/websocket/LICENSE \
	vendor/github.com/klauspost/compress/LICENSE \
	vendor/github.com/pmezard/go-difflib/LICENSE \
	vendor/golang.org/x/sys/LICENSE \
	vendor/github.com/bmatsuo/lmdb-go/LICENSE.md \
	vendor/github.com/remyoudompheng/go-liblzma/LICENSE \
	vendor/golang.org/x/term/LICENSE \
	vendor/github.com/davecgh/go-spew/LICENSE \
	vendor/github.com/klauspost/pgzip/LICENSE \
	vendor/github.com/klauspost/cpuid/v2/LICENSE \
	vendor/github.com/sirupsen/logrus/LICENSE \
	vendor/github.com/stretchr/testify/LICENSE \
	vendor/github.com/ungerik/go-sysfs/LICENSE \
	vendor/github.com/urfave/cli/v2/LICENSE \
	vendor/github.com/stretchr/objx/LICENSE \
	vendor/gopkg.in/yaml.v3/LICENSE \
	vendor/github.com/mattn/go-isatty/LICENSE \
	vendor/github.com/bmatsuo/lmdb-go/LICENSE.mdb.md

MENDER_DEPENDENCIES = host-pkgconf openssl

MENDER_LDFLAGS = -X github.com/mendersoftware/mender/conf.Version=$(MENDER_VERSION)

MENDER_UPDATE_MODULES_FILES = \
	directory \
	script \
	single-file \
	$(if $(BR2_PACKAGE_DOCKER_CLI),docker) \
	$(if $(BR2_PACKAGE_RPM),rpm)

define MENDER_INSTALL_CONFIG_FILES
	$(INSTALL) -d -m 755 $(TARGET_DIR)/etc/mender/scripts
	echo -n "3" > $(TARGET_DIR)/etc/mender/scripts/version

	$(INSTALL) -D -m 0644 $(MENDER_PKGDIR)/mender.conf \
		$(TARGET_DIR)/etc/mender/mender.conf
	$(INSTALL) -D -m 0644 $(MENDER_PKGDIR)/server.crt \
		$(TARGET_DIR)/etc/mender/server.crt

	$(INSTALL) -D -m 0755 $(@D)/support/mender-device-identity \
		$(TARGET_DIR)/usr/share/mender/identity/mender-device-identity
	$(foreach f,bootloader-integration hostinfo network os rootfs-type, \
		$(INSTALL) -D -m 0755 $(@D)/support/mender-inventory-$(f) \
			$(TARGET_DIR)/usr/share/mender/inventory/mender-inventory-$(f)
	)

	$(INSTALL) -D -m 0755 $(MENDER_PKGDIR)/artifact_info \
			$(TARGET_DIR)/etc/mender/artifact_info

	$(INSTALL) -D -m 0755 $(MENDER_PKGDIR)/device_type \
			$(TARGET_DIR)/etc/mender/device_type

	mkdir -p $(TARGET_DIR)/var/lib
	ln -snf /var/run/mender $(TARGET_DIR)/var/lib/mender
	$(foreach f,$(MENDER_UPDATE_MODULES_FILES), \
		$(INSTALL) -D -m 0755 $(@D)/support/modules/$(notdir $(f)) \
			$(TARGET_DIR)/usr/share/mender/modules/v3/$(notdir $(f))
	)
endef

MENDER_POST_INSTALL_TARGET_HOOKS += MENDER_INSTALL_CONFIG_FILES

ifeq ($(BR2_PACKAGE_XZ),y)
MENDER_DEPENDENCIES += xz
else
MENDER_TAGS += nolzma
endif

ifeq ($(BR2_PACKAGE_DBUS)$(BR2_PACKAGE_LIBGLIB2),yy)
MENDER_DEPENDENCIES += libglib2
define MENDER_INSTALL_DBUS_AUTHENTICATION_MANAGER_CONF
	$(INSTALL) -D -m 0755 $(@D)/support/dbus/io.mender.AuthenticationManager.conf \
		$(TARGET_DIR)/etc/dbus-1/system.d/io.mender.AuthenticationManager.conf

	$(INSTALL) -D -m 0755 $(@D)/support/dbus/io.mender.UpdateManager.conf \
		$(TARGET_DIR)/etc/dbus-1/system.d/io.mender.UpdateManager.conf
endef
MENDER_POST_INSTALL_TARGET_HOOKS += MENDER_INSTALL_DBUS_AUTHENTICATION_MANAGER_CONF
else
MENDER_TAGS += nodbus
endif

define MENDER_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(MENDER_PKGDIR)/mender-client.service \
		$(TARGET_DIR)/usr/lib/systemd/system/mender-client.service
endef

define MENDER_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 $(MENDER_PKGDIR)/S42mender \
		$(TARGET_DIR)/etc/init.d/S42mender
endef

$(eval $(golang-package))

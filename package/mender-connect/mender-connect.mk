################################################################################
#
# mender-connect
#
################################################################################

MENDER_CONNECT_VERSION = 2.3.0
MENDER_CONNECT_SITE = $(call github,mendersoftware,mender-connect,$(MENDER_CONNECT_VERSION))
MENDER_CONNECT_LICENSE = Apache-2.0, BSD-2-Clause, BSD-3-Clause, ISC, MIT

# Vendor license paths generated with:
#    awk '{print $2}' LIC_FILES_CHKSUM.sha256 | grep vendor
MENDER_CONNECT_LICENSE_FILES = \
	LIC_FILES_CHKSUM.sha256 \
	LICENSE \
	vendor/github.com/mendersoftware/go-lib-micro/LICENSE \
	vendor/github.com/pkg/errors/LICENSE \
	vendor/github.com/vmihailenco/msgpack/v5/LICENSE \
	vendor/github.com/vmihailenco/tagparser/v2/LICENSE \
	vendor/github.com/pmezard/go-difflib/LICENSE \
	vendor/golang.org/x/sys/LICENSE \
	vendor/golang.org/x/net/LICENSE \
	vendor/github.com/gorilla/websocket/LICENSE \
	vendor/github.com/davecgh/go-spew/LICENSE \
	vendor/github.com/creack/pty/LICENSE \
	vendor/github.com/go-ozzo/ozzo-validation/v4/LICENSE \
	vendor/github.com/satori/go.uuid/LICENSE \
	vendor/github.com/sirupsen/logrus/LICENSE \
	vendor/github.com/stretchr/objx/LICENSE \
	vendor/github.com/stretchr/testify/LICENSE \
	vendor/github.com/urfave/cli/v2/LICENSE \
	vendor/gopkg.in/yaml.v3/LICENSE

MENDER_CONNECT_DEPENDENCIES = \
	dbus \
	libglib2 \
	mender \
	openssl

MENDER_CONNECT_LDFLAGS = -X github.com/mendersoftware/mender-connect/config.Version=$(MENDER_CONNECT_VERSION)

define MENDER_CONNECT_INSTALL_CONFIG_FILES
	$(INSTALL) -d -m 755 $(TARGET_DIR)/etc/mender

	$(INSTALL) -D -m 0644 $(@D)/examples/mender-connect.conf \
		$(TARGET_DIR)/etc/mender/mender-connect.conf
endef
MENDER_CONNECT_POST_INSTALL_TARGET_HOOKS += MENDER_CONNECT_INSTALL_CONFIG_FILES

define MENDER_CONNECT_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/support/mender-connect.service \
		$(TARGET_DIR)/usr/lib/systemd/system/mender-connect.service
endef

define MENDER_CONNECT_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(MENDER_CONNECT_PKGDIR)/S43mender-connect \
		$(TARGET_DIR)/etc/init.d/S43mender-connect
endef

$(eval $(golang-package))

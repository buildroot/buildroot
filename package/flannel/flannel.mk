################################################################################
#
# flannel
#
################################################################################

FLANNEL_VERSION = 0.26.0
FLANNEL_SITE = $(call github,flannel-io,flannel,v$(FLANNEL_VERSION))

FLANNEL_LICENSE = Apache-2.0
FLANNEL_LICENSE_FILES = LICENSE

FLANNEL_LDFLAGS = -X github.com/flannel-io/flannel/version.Version=$(FLANNEL_VERSION)

# Install flannel to its well known location.
define FLANNEL_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/flannel $(TARGET_DIR)/opt/bin/flanneld
	$(INSTALL) -D -m 0755 $(@D)/dist/mk-docker-opts.sh $(TARGET_DIR)/opt/bin/mk-docker-opts.sh
endef

$(eval $(golang-package))

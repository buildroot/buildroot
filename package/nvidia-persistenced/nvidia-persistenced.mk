################################################################################
#
# nvidia-persistenced
#
################################################################################

NVIDIA_PERSISTENCED_VERSION = 560.35.03
NVIDIA_PERSISTENCED_SITE = $(call github,NVIDIA,nvidia-persistenced,$(NVIDIA_PERSISTENCED_VERSION))
NVIDIA_PERSISTENCED_LICENSE = MIT
NVIDIA_PERSISTENCED_LICENSE_FILES = COPYING

NVIDIA_PERSISTENCED_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_PACKAGE_LIBTIRPC),y)
NVIDIA_PERSISTENCED_DEPENDENCIES += libtirpc
endif

define NVIDIA_PERSISTENCED_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) -C $(@D) \
		OUTPUTDIR=. ./nvidia-persistenced.unstripped
endef

define NVIDIA_PERSISTENCED_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/nvidia-persistenced.unstripped \
		$(TARGET_DIR)/usr/bin/nvidia-persistenced
endef

ifeq ($(BR2_PACKAGE_SYSTEMD_SYSUSERS),y)
define NVIDIA_PERSISTENCED_INSTALL_SYSTEMD_SYSUSERS
	$(INSTALL) -D -m 0644 $(NVIDIA_PERSISTENCED_PKGDIR)/nvidia-persistenced.conf \
		$(TARGET_DIR)/usr/lib/sysusers.d/nvidia-persistenced.conf
endef
else
define NVIDIA_PERSISTENCED_USERS
	nvidia-persistenced -1 nvidia-persistenced -1 * - - - NVIDIA Persistence Daemon
endef
endif

define NVIDIA_PERSISTENCED_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/init/systemd/nvidia-persistenced.service.template \
		$(TARGET_DIR)/usr/lib/systemd/system/nvidia-persistenced.service
	$(SED) 's/__USER__/nvidia-persistenced/g' \
		$(TARGET_DIR)/usr/lib/systemd/system/nvidia-persistenced.service
	$(NVIDIA_PERSISTENCED_INSTALL_SYSTEMD_SYSUSERS)
endef

$(eval $(generic-package))

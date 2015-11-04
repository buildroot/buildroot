################################################################################
#
# bcm-refsw
#
################################################################################

BCM_REFSW_VERSION = 20150619
BCM_REFSW_SOURCE = refsw_release_unified_$(BCM_REFSW_VERSION).src.tar.xz
BCM_REFSW_SITE = file://../bcm-refsw
BCM_REFSW_STRIP_COMPONENTS = 0
BCM_REFSW_DEPENDENCIES = linux host-pkgconf host-flex host-bison host-gperf
BCM_REFSW_LICENSE = PROPRIETARY

BCM_REFSW_PLATFORM = 97439
BCM_REFSW_PLATFORM_REV = B0
BCM_REFSW_PLATFORM_VC = vc5

BCM_REFSW_CONF_OPTS += \
	CROSS_COMPILE="${TARGET_CROSS}" \
	LINUX=${LINUX_DIR} \
	HOST_DIR="${HOST_DIR}"

BCM_REFSW_MAKE_ENV += \
	B_REFSW_ARCH=$(ARCH)-linux \
	B_REFSW_VERBOSE=y \
	BCHP_VER=$(BCM_REFSW_PLATFORM_REV) \
	NEXUS_TOP="$(@D)/nexus" \
	NEXUS_PLATFORM=$(BCM_REFSW_PLATFORM) \
	NEXUS_USE_7439_SFF=y \
	NEXUS_MODE=proxy \
	VCX=$(BCM_REFSW_PLATFORM_VC)

BCM_REFSW_OUTPUT = "$(@D)/obj.${BCM_REFSW_PLATFORM}"
BCM_REWSW_BIN = "${BCM_REFSW_OUTPUT}/nexus/bin"

define BCM_REFSW_BUILD_NEXUS
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(@D)/nexus/build all
endef

define BCM_REFSW_BUILD_VCX
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(@D)/rockford/middleware/${BCM_REFSW_PLATFORM_VC}/driver -f V3DDriver.mk \
			OBJDIR=${BCM_REFSW_OUTPUT}/rockford/middleware/v3d/driver/obj_${BCM_REFSW_PLATFORM}_release \
			LIBDIR=${BCM_REWSW_BIN}
	$(TARGET_CONFIGURE_OPTS) \
	$(TARGET_MAKE_ENV) \
	$(BCM_REFSW_CONF_OPTS) \
	$(BCM_REFSW_MAKE_ENV) \
		$(MAKE) -C $(@D)/rockford/middleware/${BCM_REFSW_PLATFORM_VC}/platform/nexus -f platform_nexus.mk \
			OBJDIR=${BCM_REFSW_OUTPUT}/rockford/middleware/v3d/platform/obj_${BCM_REFSW_PLATFORM}_release \
			LIBDIR=${BCM_REWSW_BIN}
endef

define BCM_REFSW_BUILD_CMDS
	$(BCM_REFSW_BUILD_NEXUS)
	$(BCM_REFSW_BUILD_VCX)
endef

$(eval $(generic-package))

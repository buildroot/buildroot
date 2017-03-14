################################################################################
#
# kylin-mali
#
################################################################################

KYLIN_MALI_VERSION = db6b4078eb8d4593fdb26fac41c9fd4878fe2af6
KYLIN_MALI_SITE_METHOD = git
KYLIN_MALI_SITE = git@github.com:Metrological/kylin-mali.git
KYLIN_MALI_INSTALL_STAGING = YES
KYLIN_MALI_DEPENDENCIES += linux

KYLIN_MALI_MAKE_ENV = MALI_ARCH=arm64 \
                      MALI_CROSS_COMPILE=aarch64-buildroot-linux-gnu- \
                      KERNEL_SRC=${LINUX_DIR} \
                      KERNEL_PATH=${LINUX_DIR} \
                      KERNEL_VERSION=$(LINUX_VERSION_PROBED) \
                      SOURCE_ROOT_DIR=$(@D) \
                      ARCH=arm64
                      

define KYLIN_MALI_BUILD_CMDS
    $(MAKE) $(KYLIN_MALI_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
    $(MAKE) $(KYLIN_MALI_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) -C $(@D) strip
endef

define KYLIN_MALI_INSTALL_STAGING_CMDS
    $(MAKE) $(KYLIN_MALI_MAKE_ENV) INSTALL_MOD_PATH=${STAGING_DIR} $(TARGET_CONFIGURE_OPTS) -C $(@D) modules_install
endef

define KYLIN_MALI_INSTALL_TARGET_CMDS
    $(MAKE) $(KYLIN_MALI_MAKE_ENV) INSTALL_MOD_PATH=${TARGET_DIR} $(TARGET_CONFIGURE_OPTS) -C $(@D) modules_install
endef

$(eval $(generic-package))

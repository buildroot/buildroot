################################################################################
#
# intelce-pic24_uart_drv
#
################################################################################
INTELCE_PIC24_UART_DRV_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_PIC24_UART_DRV_SITE = ${INTELCE_SDK_DIR}/pic24_uart_drv
INTELCE_PIC24_UART_DRV_SITE_METHOD = local
INTELCE_PIC24_UART_DRV_LICENSE = PROPRIETARY
INTELCE_PIC24_UART_DRV_REDISTRIBUTE = NO
INTELCE_PIC24_UART_DRV_DEPENDENCIES = intelce-sdk intelce-osal intelce-intel_ce_pm
INTELCE_PIC24_UART_DRV_INSTALL_STAGING = YES

define INTELCE_PIC24_UART_DRV_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_PIC24_UART_DRV_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_PIC24_UART_DRV_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target 
endef

$(eval $(generic-package))

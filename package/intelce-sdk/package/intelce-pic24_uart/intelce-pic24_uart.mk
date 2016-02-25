################################################################################
#
# intelce-pic24_uart
#
################################################################################
INTELCE_PIC24_UART_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_PIC24_UART_SITE = ${INTELCE_SDK_DIR}/pic24_uart
INTELCE_PIC24_UART_SITE_METHOD = local
INTELCE_PIC24_UART_LICENSE = PROPRIETARY
INTELCE_PIC24_UART_REDISTRIBUTE = NO
INTELCE_PIC24_UART_DEPENDENCIES = intelce-sdk intelce-osal intelce-idts_common
INTELCE_PIC24_UART_INSTALL_STAGING = YES
  
define INTELCE_PIC24_UART_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_PIC24_UART_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install 
endef

define INTELCE_PIC24_UART_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install 
endef

$(eval $(generic-package))

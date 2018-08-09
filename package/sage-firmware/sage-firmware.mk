################################################################################
#
# sage-firmware
#
################################################################################
SAGE_FIRMWARE_VERSION = master
SAGE_FIRMWARE_SITE = git@github.com:Metrogical/bcm-sage.git
SAGE_FIRMWARE_SITE_METHOD = git
SAGE_FIRMWARE_INSTALL_STAGING = NO
SAGE_FIRMWARE_INSTALL_TARGET = YES

$(eval $(virtual-package))

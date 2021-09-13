################################################################################
#
# optee-client
#
################################################################################

OPTEE_CLIENT_VERSION = 3.4.0
OPTEE_CLIENT_SITE = $(call github,OP-TEE,optee_client,$(OPTEE_CLIENT_VERSION))
OPTEE_CLIENT_LICENSE = BSD-2-Clause
OPTEE_CLIENT_LICENSE_FILES = LICENSE
OPTEE_CLIENT_INSTALL_STAGING = YES

$(eval $(cmake-package))

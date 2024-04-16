################################################################################
#
# valijson
#
################################################################################

VALIJSON_VERSION = 1.0.2
VALIJSON_SITE = $(call github,tristanpenman,valijson,v$(VALIJSON_VERSION))
VALIJSON_LICENSE = BSD-2-Clause
VALIJSON_LICENSE_FILES = LICENSE
VALIJSON_CPE_ID_VALID = YES
VALIJSON_INSTALL_STAGING = YES
VALIJSON_INSTALL_TARGET = NO
VALIJSON_CONF_OPTS = -Dvalijson_BUILD_TESTS=FALSE

$(eval $(cmake-package))

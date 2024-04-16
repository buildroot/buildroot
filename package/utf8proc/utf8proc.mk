################################################################################
#
# utf8proc
#
################################################################################

UTF8PROC_VERSION = 2.9.0
UTF8PROC_SITE = https://github.com/JuliaStrings/utf8proc/releases/download/v$(UTF8PROC_VERSION)
UTF8PROC_LICENSE = MIT
UTF8PROC_LICENSE_FILES = LICENSE.md
UTF8PROC_INSTALL_STAGING = YES
UTF8PROC_SUPPORTS_IN_SOURCE_BUILD = NO

$(eval $(cmake-package))

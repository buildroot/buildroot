################################################################################
#
# fdk-aac
#
################################################################################

ifeq ($(BR2_PACKAGE_NETFLIX52),y)
FDK_AAC_VERSION = 0.1.5
else
FDK_AAC_VERSION = 0.1.4
endif
FDK_AAC_SITE = http://downloads.sourceforge.net/project/opencore-amr/files/fdk-aac
FDK_AAC_LICENSE = fdk-aac license
FDK_AAC_LICENSE_FILES = NOTICE

FDK_AAC_INSTALL_STAGING = YES

# Not compatible with GCC 6 which defaults to GNU++14
FDK_AAC_CONF_ENV += CXXFLAGS="$(TARGET_CXXFLAGS) -std=gnu++98"

$(eval $(autotools-package))

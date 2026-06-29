################################################################################
#
# openjpeg
#
################################################################################

OPENJPEG_VERSION = 2.5.4
OPENJPEG_SITE = $(call github,uclouvain,openjpeg,v$(OPENJPEG_VERSION))
OPENJPEG_LICENSE = BSD-2-Clause
OPENJPEG_LICENSE_FILES = LICENSE
OPENJPEG_CPE_ID_VENDOR = uclouvain
OPENJPEG_INSTALL_STAGING = YES

# 0001-opj-pi-initialise-encode-avoid-potential-integer-overflow-leading-to-insufficient-memory-allocation.patch
OPENJPEG_IGNORE_CVES += CVE-2026-6192

OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_ZLIB),zlib)
OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_LIBPNG),libpng)
OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_TIFF),tiff)
OPENJPEG_DEPENDENCIES += $(if $(BR2_PACKAGE_LCMS2),lcms2)

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
OPENJPEG_CONF_OPTS += -DOPJ_USE_THREAD=ON
else
OPENJPEG_CONF_OPTS += -DOPJ_USE_THREAD=OFF
endif

$(eval $(cmake-package))

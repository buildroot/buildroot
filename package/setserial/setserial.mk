################################################################################
#
# setserial
#
################################################################################

SETSERIAL_VERSION = 2.17
SETSERIAL_SOURCE = setserial_$(SETSERIAL_VERSION).orig.tar.gz
SETSERIAL_SITE = https://snapshot.debian.org/archive/debian/20250307T084701Z/pool/main/s/setserial
SETSERIAL_EXTRA_DOWNLOADS = setserial_$(SETSERIAL_VERSION)-57.debian.tar.xz
SETSERIAL_LICENSE = GPL-2.0
SETSERIAL_LICENSE_FILES = debian/copyright
# make all also builds setserial.cat which needs nroff
SETSERIAL_MAKE_OPTS = setserial

SETSERIAL_AUTORECONF = YES

# Extract the Debian tarball inside the sources
define SETSERIAL_DEBIAN_EXTRACT
	$(call suitable-extractor,$(notdir $(SETSERIAL_EXTRA_DOWNLOADS))) \
		$(SETSERIAL_DL_DIR)/$(notdir $(SETSERIAL_EXTRA_DOWNLOADS)) | \
		$(TAR) -C $(@D) $(TAR_OPTIONS) -
endef

SETSERIAL_POST_EXTRACT_HOOKS += SETSERIAL_DEBIAN_EXTRACT

define SETSERIAL_APPLY_DEBIAN_PATCHES
	# - Touching gorhack.h is needed for the Debian patch 18 to work
	# - Apply patches in the order listed in debian/patches/series
	if [ -d $(@D)/debian/patches ]; then \
		touch $(@D)/gorhack.h; \
		$(APPLY_PATCHES) $(@D) $(@D)/debian/patches series; \
	fi
endef

SETSERIAL_PRE_PATCH_HOOKS += SETSERIAL_APPLY_DEBIAN_PATCHES

$(eval $(autotools-package))

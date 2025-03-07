################################################################################
#
# setserial
#
################################################################################

SETSERIAL_VERSION = 2.17
SETSERIAL_SOURCE = setserial_$(SETSERIAL_VERSION).orig.tar.gz
SETSERIAL_SITE = http://snapshot.debian.org/archive/debian/20141023T043132Z/pool/main/s/setserial
SETSERIAL_EXTRA_DOWNLOADS = setserial_2.17-45.3.diff.gz
SETSERIAL_LICENSE = GPL-2.0
SETSERIAL_LICENSE_FILES = debian/copyright
# make all also builds setserial.cat which needs nroff
SETSERIAL_MAKE_OPTS = setserial

SETSERIAL_AUTORECONF = YES

# Extract the Debian tarball inside the sources
define SETSERIAL_DEBIAN_EXTRACT
	$(call suitable-extractor,$(notdir $(SETSERIAL_EXTRA_DOWNLOADS))) \
		$(SETSERIAL_DL_DIR)/$(notdir $(SETSERIAL_EXTRA_DOWNLOADS)) > $(@D)/setserial_2.17-45.3.diff
endef

SETSERIAL_POST_EXTRACT_HOOKS += SETSERIAL_DEBIAN_EXTRACT

define SETSERIAL_APPLY_DEBIAN_PATCHES
	# - Applying diff gotten from SETSERIAL_EXTRA_DOWNLOADS
	# - Touching gorhack.h is needed for the Debian patch 18 to work
	# - Rename 00list which contains the list of patches to "series" so
	#   Buildroot knows in which order the patches need to be applied. This
	#   is necessary because their file extension is dpatch, which isn't
	#   supported by the APPLY_PATCHES script outside of the series
	#   mechanism.
	$(APPLY_PATCHES) $(@D) $(@D) setserial_2.17-45.3.diff

	if [ -d $(@D)/debian/patches ]; then \
		touch $(@D)/gorhack.h; \
		rm $(@D)/debian/patches/01_makefile.dpatch; \
		mv $(@D)/debian/patches/00list $(@D)/debian/patches/series; \
		sed -i '/01_makefile.dpatch/d' $(@D)/debian/patches/series; \
		$(APPLY_PATCHES) $(@D) $(@D)/debian/patches series; \
	fi
endef

SETSERIAL_PRE_PATCH_HOOKS += SETSERIAL_APPLY_DEBIAN_PATCHES

$(eval $(autotools-package))

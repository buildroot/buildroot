################################################################################
#
# This file contains various utility functions used by the package
# infrastructure, or by the packages themselves.
#
################################################################################

#
# Manipulation of .config files based on the Kconfig
# infrastructure. Used by the BusyBox package, the Linux kernel
# package, and more.
#

# KCONFIG_DOT_CONFIG ([file])
# Returns the path to the .config file that should be used, which will
# be $(1) if provided, or the current package .config file otherwise.
KCONFIG_DOT_CONFIG = $(strip \
	$(if $(strip $(1)), $(1), \
		$($(PKG)_BUILDDIR)/$($(PKG)_KCONFIG_DOTCONFIG) \
	) \
)

# KCONFIG_MUNGE_DOT_CONFIG (option, newline [, file])
define KCONFIG_MUNGE_DOT_CONFIG
	$(SED) '/^\(# \)\?$(strip $(1))\>/d' $(call KCONFIG_DOT_CONFIG,$(3)) && \
	echo '$(strip $(2))' >> $(call KCONFIG_DOT_CONFIG,$(3))
endef

# KCONFIG_ENABLE_OPT (option [, file])
# If the option is already set to =m or =y, ignore.
define KCONFIG_ENABLE_OPT
	$(Q)if ! grep -q '^$(strip $(1))=[my]' $(call KCONFIG_DOT_CONFIG,$(2)); then \
		$(call KCONFIG_MUNGE_DOT_CONFIG, $(1), $(1)=y, $(2)); \
	fi
endef
# KCONFIG_SET_OPT (option, value [, file])
KCONFIG_SET_OPT     = $(call KCONFIG_MUNGE_DOT_CONFIG, $(1), $(1)=$(2), $(3))
# KCONFIG_DISABLE_OPT  (option [, file])
KCONFIG_DISABLE_OPT = $(call KCONFIG_MUNGE_DOT_CONFIG, $(1), $(SHARP_SIGN) $(1) is not set, $(2))

# Helper functions to determine the name of a package and its
# directory from its makefile directory, using the $(MAKEFILE_LIST)
# variable provided by make. This is used by the *-package macros to
# automagically find where the package is located.
pkgdir = $(dir $(lastword $(MAKEFILE_LIST)))
pkgname = $(lastword $(subst /, ,$(pkgdir)))

# Helper to build the extension for a package archive, based on various
# conditions.
# $(1): upper-case package name
pkg_source_ext = $(BR_FMT_VERSION_$($(1)_SITE_METHOD)).tar.gz

# Define extractors for different archive suffixes
INFLATE.bz2  = $(BZCAT)
INFLATE.gz   = $(ZCAT)
INFLATE.lz   = $(LZCAT)
INFLATE.lzma = $(XZCAT)
INFLATE.tbz  = $(BZCAT)
INFLATE.tbz2 = $(BZCAT)
INFLATE.tgz  = $(ZCAT)
INFLATE.xz   = $(XZCAT)
INFLATE.tar  = cat
# suitable-extractor(filename): returns extractor based on suffix
suitable-extractor = $(INFLATE$(suffix $(1)))

EXTRACTOR_PKG_DEPENDENCY.lzma = $(BR2_XZCAT_HOST_DEPENDENCY)
EXTRACTOR_PKG_DEPENDENCY.xz   = $(BR2_XZCAT_HOST_DEPENDENCY)
EXTRACTOR_PKG_DEPENDENCY.lz   = $(BR2_LZIP_HOST_DEPENDENCY)

# extractor-pkg-dependency(filename): returns a Buildroot package
# dependency needed to extract file based on suffix
extractor-pkg-dependency = $(EXTRACTOR_PKG_DEPENDENCY$(suffix $(1)))

# extractor-system-dependency(filename): returns the name of the tool
# needed to extract 'filename', and is meant to be used with
# DL_TOOLS_DEPENDENCIES, in order to check that the necesary tool is
# provided by the system Buildroot runs on.
#
# $(firstword) is used here because the extractor can have arguments,
# like ZCAT="gzip -d -c", and to check for the dependency we only want
# 'gzip'.
extractor-system-dependency = $(if $(EXTRACTOR_PKG_DEPENDENCY$(suffix $(1))),,\
	$(firstword $(INFLATE$(suffix $(1)))))

# check-deprecated-variable -- throw an error on deprecated variables
# example:
#   $(eval $(call check-deprecated-variable,FOO_MAKE_OPT,FOO_MAKE_OPTS))
define check-deprecated-variable # (deprecated var, new var)
ifneq ($$(origin $(1)),undefined)
$$(error Package error: use $(2) instead of $(1). Please fix your .mk file)
endif
endef

# $(1): YES or NO
define yesno-to-bool
	$(subst NO,false,$(subst YES,true,$(1)))
endef

# json-info -- return package or filesystem metadata formatted as an entry
#              of a JSON dictionnary
# $(1): upper-case package or filesystem name
define json-info
	"$($(1)_NAME)": {
		"type": $(call mk-json-str,$($(1)_TYPE)),
		$(if $(filter rootfs,$($(1)_TYPE)), \
			$(call _json-info-fs,$(1)), \
			$(call _json-info-pkg,$(1)), \
		)
	}
endef

# _json-info-pkg, _json-info-pkg-details, _json-info-fs: private helpers
# for json-info, above
define _json-info-pkg
	"name": $(call mk-json-str,$($(1)_RAWNAME)),
	$(if $($(1)_IS_VIRTUAL), \
		"virtual": true$(comma),
		"virtual": false$(comma)
		$(call _json-info-pkg-details,$(1)) \
	)
	"stamp_dir": $(call mk-json-str,$(patsubst $(CONFIG_DIR)/%,%,$($(1)_DIR))),
	"source_dir": $(call mk-json-str,$(patsubst $(CONFIG_DIR)/%,%,$($(1)_DIR))),
	"build_dir": $(call mk-json-str,$(patsubst $(CONFIG_DIR)/%,%,$($(1)_BUILDDIR))),
	$(if $(filter target,$($(1)_TYPE)), \
		"install_target": $(call yesno-to-bool,$($(1)_INSTALL_TARGET))$(comma) \
		"install_staging": $(call yesno-to-bool,$($(1)_INSTALL_STAGING))$(comma) \
		"install_images": $(call yesno-to-bool,$($(1)_INSTALL_IMAGES))$(comma) \
	)
	"dependencies": [
		$(call make-comma-list, \
			$(foreach dep,$(sort $($(1)_FINAL_ALL_DEPENDENCIES)), \
				$(call mk-json-str,$(dep)) \
			) \
		)
	],
	"reverse_dependencies": [
		$(call make-comma-list, \
			$(foreach dep,$(sort $($(1)_RDEPENDENCIES)), \
				$(call mk-json-str,$(dep)) \
			) \
		)
	]
	$(if $($(1)_CPE_ID_VALID), \
		$(comma) "cpe-id": $(call mk-json-str,$($(1)_CPE_ID)) \
	)
	$(if $($(1)_IGNORE_CVES),
		$(comma) "ignore_cves": [
			$(call make-comma-list, \
				$(foreach cve,$(sort $($(1)_IGNORE_CVES)), \
					$(call mk-json-str,$(cve)) \
				) \
			)
		]
	)
endef

define _json-info-pkg-details
	"version": $(call mk-json-str,$($(1)_DL_VERSION)),
	"licenses": $(call mk-json-str,$($(1)_LICENSE)),
	"dl_dir": $(call mk-json-str,$($(1)_DL_SUBDIR)),
	"downloads": [
	$(foreach dl,$(sort $($(1)_ALL_DOWNLOADS)),
		{
			"source": $(call mk-json-str,$(notdir $(dl))),
			"uris": [
				$(call make-comma-list, \
					$(foreach uri,$(call DOWNLOAD_URIS,$(dl),$(1)), \
						$(call mk-json-str,$(subst \|,|,$(uri))) \
					) \
				)
			]
		},
	)
	],
endef

define _json-info-fs
	"image_name": $(if $($(1)_FINAL_IMAGE_NAME), \
				$(call mk-json-str,$($(1)_FINAL_IMAGE_NAME)), \
				null \
			),
	"dependencies": [
		$(call make-comma-list, \
			$(foreach dep,$(sort $($(1)_DEPENDENCIES)), \
				$(call mk-json-str,$(dep)) \
			) \
		)
	]
endef

# clean-json -- cleanup pseudo-json into clean json:
#  - remove commas before closing ] and }
#  - minify with $(strip)
clean-json = $(strip \
	$(subst $(comma)},}, $(subst $(comma)$(space)},$(space)}, \
	$(subst $(comma)],], $(subst $(comma)$(space)],$(space)], \
		$(strip $(1)) \
	)))) \
)

# mk-json-str -- escape and double-quote a string to make it a valid json string
#  - escape \
#  - escape "
#  - escape \n
#  - escape \t
#  - escape ESC
#  - escape SPACE (so that we can $(strip) a JSON blurb without squashing multiple spaces)
# This unfortunately has to be on a single line...
mk-json-str = "$(subst $(space),\u0020,$(subst $(escape),\u001b,$(subst $(tab),\t,$(subst $(sep),\n,$(subst ",\",$(subst \,\\,$(1)))))))"
# )))))" # Syntax colouring

ifeq ($(BR2_PER_PACKAGE_DIRECTORIES),y)
# rsync the contents of per-package directories
# $1: space-separated list of packages to rsync from
# $2: 'host' or 'target'
# $3: destination directory
define per-package-rsync
	mkdir -p $(3)
	$(foreach pkg,$(1),\
		rsync -a --link-dest=$(PER_PACKAGE_DIR)/$(pkg)/$(2)/ \
			$(PER_PACKAGE_DIR)/$(pkg)/$(2)/ \
			$(3)$(sep))
endef

# prepares the per-package HOST_DIR and TARGET_DIR of the current
# package, by rsync the host and target directories of the
# dependencies of this package. The list of dependencies is passed as
# argument, so that this function can be used to prepare with
# different set of dependencies (download, extract, configure, etc.)
#
# $1: space-separated list of packages to rsync from
define prepare-per-package-directory
	$(call per-package-rsync,$(1),host,$(HOST_DIR))
	$(call per-package-rsync,$(1),target,$(TARGET_DIR))
endef
endif

#
# legal-info helper functions
#
LEGAL_INFO_SEPARATOR = "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"

define legal-warning # text
	echo "WARNING: $(1)" >>$(LEGAL_WARNINGS)
endef

define legal-warning-pkg # pkg, text
	echo "WARNING: $(1): $(2)" >>$(LEGAL_WARNINGS)
endef

define legal-warning-nosource # pkg, {local|override}
	$(call legal-warning-pkg,$(1),sources not saved ($(2) packages not handled))
endef

define legal-manifest # {HOST|TARGET}, pkg, version, license, license-files, source, url, dependencies
	echo '"$(2)","$(3)","$(4)","$(5)","$(6)","$(7)","$(8)"' >>$(LEGAL_MANIFEST_CSV_$(1))
endef

define legal-license-file # pkgname, pkgname-pkgver, pkg-hashfile, filename, file-fullpath, {HOST|TARGET}
	mkdir -p $(LICENSE_FILES_DIR_$(6))/$(2)/$(dir $(4)) && \
	{ \
		support/download/check-hash $(3) $(5) $(4); \
		case $${?} in (0|3) ;; (*) exit 1;; esac; \
	} && \
	cp $(5) $(LICENSE_FILES_DIR_$(6))/$(2)/$(4)
endef

non-virtual-deps = $(foreach p,$(1),$(if $($(call UPPERCASE,$(p))_IS_VIRTUAL),,$(p)))

# Returns the list of recursive dependencies and their licensing terms
# for the package specified in parameter (in lowercase). If that
# package is a target package, remove host packages from the list.
legal-deps = \
    $(foreach p,\
        $(filter-out $(if $(1:host-%=),host-%),\
            $(call non-virtual-deps,\
                $($(call UPPERCASE,$(1))_FINAL_RECURSIVE_DEPENDENCIES))),$(p) [$($(call UPPERCASE,$(p))_LICENSE)])

# Helper for self-extracting binaries distributed by NXP, and
# formerlly Freescale.
#
# The --force option makes sure it doesn't fail if the source
# directory already exists. The --auto-accept skips the license check,
# as it is not needed in Buildroot because we have legal-info. Since
# there's a EULA in the binary file, we extract it in this macro, and
# it should therefore be added to the LICENSE_FILES variable of
# packages using this macro. Also, remember to set REDISTRIBUTE to
# "NO". Indeed, this is a legal minefield: the EULA specifies that the
# Board Support Package includes software and hardware (sic!) for
# which a separate license is needed...
#
# $(1): full path to the archive file
#
define NXP_EXTRACT_HELPER
	awk 'BEGIN      { start = 0; } \
	     /^EOEULA/  { start = 0; } \
	                { if (start) print; } \
	     /<<EOEULA/ { start = 1; }' \
	    $(1) > $(@D)/EULA
	cd $(@D) && sh $(1) --force --auto-accept
	find $(@D)/$(basename $(notdir $(1))) -mindepth 1 -maxdepth 1 -exec mv {} $(@D) \;
	rmdir $(@D)/$(basename $(notdir $(1)))
endef

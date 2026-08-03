################################################################################
# Hare package infrastructure
# see https://harelang.org/
#
# This file implements an infrastructure that eases development of
# package .mk files for Hare packages.
#
# See the Buildroot documentation for details on the usage of this
# infrastructure
#
# In terms of implementation, this Hare infrastructure requires
# the .mk file to only specify metadata information about the
# package: name, version, etc.
#
################################################################################

HARE_RUN_CMD = \
	PATH=$(BR_PATH) \
	HAREPATH="$(HOST_DIR)/src/hare/stdlib:$(STAGING_DIR)/usr/src/hare/third-party" \
	$(HOST_DIR)/bin/hare
HARE_ARCH_OPT = -a $(ARCH)
HARE_LIBDIR_OPT = -L $(STAGING_DIR)/usr/lib

################################################################################
# inner-hare-package -- defines how the configuration, compilation and
# installation of a Hare package should be done, implements a few hooks to
# tune the build process and calls the generic package infrastructure to
# generate the necessary make targets
#
#  argument 1 is the lowercase package name
#  argument 2 is the uppercase package name, including a HOST_ prefix
#             for host packages
#  argument 3 is the uppercase package name, without the HOST_ prefix
#             for host packages
#  argument 4 is the type (target or host)
################################################################################

define inner-hare-package

$(2)_DEPENDENCIES += host-hare

#
# Build step. Only define it if not already defined by the package .mk
# file.
#
ifndef $(2)_BUILD_CMDS
# in perfect world, all project follows the conventions described in
# https://harelang.org/documentation/usage/project-structure.html#makefiles
# but in real world, the target "all" is not always the default one
define $(2)_BUILD_CMDS
	if grep "^all:" $$($(2)_SRCDIR)Makefile > /dev/null; then \
		$(MAKE) -C $$($(2)_SRCDIR) HARE="$$(HARE_RUN_CMD)" HAREFLAGS="$$(HARE_ARCH_OPT) $$(HARE_LIBDIR_OPT)" all; \
	else \
		$(MAKE) -C $$($(2)_SRCDIR) HARE="$$(HARE_RUN_CMD)" HAREFLAGS="$$(HARE_ARCH_OPT) $$(HARE_LIBDIR_OPT)"; \
	fi
endef
endif

#
# Staging installation step. Only define it if not already defined by
# the package .mk file.
#
ifndef $(2)_INSTALL_STAGING_CMDS
define $(2)_INSTALL_STAGING_CMDS
	$(MAKE) -C $$($(2)_SRCDIR) PREFIX=/usr DESTDIR="$$(STAGING_DIR)" install
endef
endif

#
# Target installation step. Only define it if not already defined by
# the package .mk file.
#
ifndef $(2)_INSTALL_TARGET_CMDS
define $(2)_INSTALL_TARGET_CMDS
	$(MAKE) -C $$($(2)_SRCDIR) PREFIX=/usr DESTDIR="$$(TARGET_DIR)" install
endef
endif

# Call the generic package infrastructure to generate the necessary
# make targets
$(call inner-generic-package,$(1),$(2),$(3),$(4))

endef

################################################################################
# hare-package -- the target generator macro for Hare packages
################################################################################

hare-package = $(call inner-hare-package,$(pkgname),$(call UPPERCASE,$(pkgname)),$(call UPPERCASE,$(pkgname)),target)

################################################################################
# Cleanup target /usr/src/hare
################################################################################

define HARE_FINALIZE_TARGET
	rm -rf $(TARGET_DIR)/usr/src/hare
endef

TARGET_FINALIZE_HOOKS += HARE_FINALIZE_TARGET

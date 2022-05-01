################################################################################
#
# falcosecurity-libs
#
################################################################################

FALCOSECURITY_LIBS_VERSION = e5c53d648f3c4694385bbe488e7d47eaa36c229a
FALCOSECURITY_LIBS_SITE = $(call github,falcosecurity,libs,$(FALCOSECURITY_LIBS_VERSION))
FALCOSECURITY_LIBS_LICENSE = Apache-2.0 (userspace), MIT or GPL-2.0 (driver)
FALCOSECURITY_LIBS_LICENSE_FILES = COPYING driver/MIT.txt driver/GPL2.txt
FALCOSECURITY_LIBS_CPE_ID_VENDOR = falco
FALCOSECURITY_LIBS_SUPPORTS_IN_SOURCE_BUILD = NO

FALCOSECURITY_LIBS_DEPENDENCIES = \
	c-ares \
	elfutils \
	grpc \
	gtest \
	host-grpc \
	host-protobuf \
	jq \
	jsoncpp \
	libb64 \
	libcurl \
	luainterpreter \
	openssl \
	protobuf \
	tbb \
	valijson \
	zlib

FALCOSECURITY_LIBS_DRIVER_NAME = scap
FALCOSECURITY_LIBS_MODULE_SUBDIRS = driver
FALCOSECURITY_LIBS_MODULE_MAKE_OPTS = KERNELDIR=$(LINUX_DIR)

# falcosecurity-libs module needs these two kernel options to be set:
# CONFIG_TRACEPOINTS
# CONFIG_HAVE_SYSCALL_TRACEPOINTS
# https://github.com/draios/sysdig/wiki/How-to-Install-Sysdig-from-the-Source-Code#linux-and-osx
# CONFIG_FTRACE and CONFIG_SCHED_TRACER selects CONFIG_GENERIC_TRACER which in
# turns select CONFIG_TRACING which in turns select CONFIG_TRACEPOINTS
define FALCOSECURITY_LIBS_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_FTRACE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_SCHED_TRACER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_HAVE_SYSCALL_TRACEPOINTS)
endef

# falcosecurity-libs creates the module Makefile from a template, which contains
# a single place-holder, KBUILD_FLAGS, wich is only replaced with debug flags,
# which we don't care about here.
# So, just replace the place-holder with the only meaningful value: nothing.
# For the DRIVER_NAME, we set it to FALCOSECURITY_LIBS_DRIVER_NAME.
# So, when sysdig will be run, it will automatically load
# FALCOSECURITY_LIBS_DRIVER_NAME.ko.
# We also need to do the same process for driver_config.h.in.
# PPM_API_CURRENT_VERSION_* were take from driver/API_VERSION and
# PPM_SCHEMA_CURRENT_VERSION_* from driver/SCHEMA_VERSION.
# For the others, it was taken by inspecting
# falcosecurity-libs/*/CMakeLists.txt, which normally creates these
# files, but doesn't work well with the kernel-module infrastructure.
define FALCOSECURITY_LIBS_MODULE_GEN_MAKEFILE
	$(INSTALL) -m 0644 $(@D)/driver/Makefile.in $(@D)/driver/Makefile
	$(SED) 's/@KBUILD_FLAGS@//;' $(@D)/driver/Makefile
	$(SED) 's/@DRIVER_NAME@/$(FALCOSECURITY_LIBS_DRIVER_NAME)/;' $(@D)/driver/Makefile

	$(INSTALL) -m 0644 $(@D)/driver/driver_config.h.in $(@D)/driver/driver_config.h
	$(SED) 's/\$${PPM_API_CURRENT_VERSION_MAJOR}/1/;' $(@D)/driver/driver_config.h
	$(SED) 's/\$${PPM_API_CURRENT_VERSION_MINOR}/0/;' $(@D)/driver/driver_config.h
	$(SED) 's/\$${PPM_API_CURRENT_VERSION_PATCH}/0/;' $(@D)/driver/driver_config.h
	$(SED) 's/\$${PPM_SCHEMA_CURRENT_VERSION_MAJOR}/1/;' $(@D)/driver/driver_config.h
	$(SED) 's/\$${PPM_SCHEMA_CURRENT_VERSION_MINOR}/0/;' $(@D)/driver/driver_config.h
	$(SED) 's/\$${PPM_SCHEMA_CURRENT_VERSION_PATCH}/0/;' $(@D)/driver/driver_config.h
	$(SED) 's/\$${DRIVER_VERSION}//;' $(@D)/driver/driver_config.h
	$(SED) 's/\$${DRIVER_NAME}/$(FALCOSECURITY_LIBS_DRIVER_NAME)/;' $(@D)/driver/driver_config.h
	$(SED) 's/\$${DRIVER_DEVICE_NAME}/$(FALCOSECURITY_LIBS_DRIVER_NAME)/;' $(@D)/driver/driver_config.h
	$(SED) 's/\$${GIT_COMMIT}/0.1.1dev/;' $(@D)/driver/driver_config.h
endef
FALCOSECURITY_LIBS_POST_PATCH_HOOKS += FALCOSECURITY_LIBS_MODULE_GEN_MAKEFILE

# Userspace components are not built and installed, because it this
# package is intended to be included as source in another build.

$(eval $(kernel-module))
$(eval $(generic-package))

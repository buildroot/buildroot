################################################################################
#
# nim
#
################################################################################

NIM_VERSION = 2.2.12
NIM_SITE = https://github.com/nim-lang/nightlies/releases/download/2026-09-08-version-2-2-8e8fbf60693418dc95bb0d762fd660231d08a583/
NIM_SOURCE = nim-$(NIM_VERSION).tar.xz
NIM_LICENSE = MIT
NIM_LICENSE_FILES = copying.txt

define HOST_NIM_BUILD_CMDS
	$(HOST_MAKE_ENV) cd $(@D) && ./build.sh
endef

define HOST_NIM_INSTALL_CMDS
	$(INSTALL) -D -m0755 $(@D)/bin/nim $(HOST_DIR)/bin/nim
	cp -dpfr $(@D)/lib/* $(HOST_DIR)/lib
endef

$(eval $(host-generic-package))

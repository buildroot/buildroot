################################################################################
#
# flutter-gallery
#
################################################################################

FLUTTER_GALLERY_VERSION = 2.10.2
FLUTTER_GALLERY_SITE = $(call github,flutter,gallery,v$(FLUTTER_GALLERY_VERSION))
FLUTTER_GALLERY_LICENSE = BSD-3-Clause
FLUTTER_GALLERY_LICENSE_FILES = LICENSE
FLUTTER_GALLERY_DEPENDENCIES = \
	host-flutter-sdk-bin \
	flutter-engine

FLUTTER_GALLERY_INSTALL_DIR = $(TARGET_DIR)/usr/share/flutter/gallery/$(FLUTTER_ENGINE_RUNTIME_MODE)

define FLUTTER_GALLERY_BUILD_CMDS
	cd $(@D) && \
		FLUTTER_RUNTIME_MODES=$(FLUTTER_ENGINE_RUNTIME_MODE) \
		$(HOST_FLUTTER_SDK_BIN_FLUTTER) clean && \
		$(HOST_FLUTTER_SDK_BIN_FLUTTER) packages get && \
		$(HOST_FLUTTER_SDK_BIN_FLUTTER) build bundle && \
		$(HOST_FLUTTER_SDK_BIN_DART_BIN) package:gallery/main.dart && \
		$(HOST_FLUTTER_SDK_BIN_ENV) $(FLUTTER_ENGINE_GEN_SNAPSHOT) \
			--deterministic \
			--snapshot_kind=app-aot-elf \
			--elf=libapp.so \
			.dart_tool/flutter_build/*/app.dill
endef

define FLUTTER_GALLERY_INSTALL_TARGET_CMDS
	mkdir -p $(FLUTTER_GALLERY_INSTALL_DIR)/{data,lib}
	cp -dprf $(@D)/build/flutter_assets $(FLUTTER_GALLERY_INSTALL_DIR)/data/

	$(INSTALL) -D -m 0755 $(@D)/libapp.so \
		$(FLUTTER_GALLERY_INSTALL_DIR)/lib/libapp.so

	ln -sf ../../../$(FLUTTER_ENGINE_RUNTIME_MODE)/data/icudtl.dat \
	$(FLUTTER_GALLERY_INSTALL_DIR)/data/

	ln -sf ../../../../../lib/libflutter_engine.so $(FLUTTER_GALLERY_INSTALL_DIR)/lib/
endef

$(eval $(generic-package))

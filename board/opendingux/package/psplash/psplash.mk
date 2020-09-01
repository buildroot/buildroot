define PSPLASH_CREATE_BAR
	cp board/opendingux/package/psplash/psplash-bar.png $(@D)/base-images/psplash-bar.png
endef
PSPLASH_PRE_BUILD_HOOKS += PSPLASH_CREATE_BAR

define PSPLASH_CREATE_POKY
	cp board/opendingux/package/psplash/psplash-poky.png $(@D)/base-images/psplash-poky.png
endef
PSPLASH_PRE_BUILD_HOOKS += PSPLASH_CREATE_POKY

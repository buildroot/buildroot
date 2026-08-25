################################################################################
#
# sound-theme-borealis
#
################################################################################

SOUND_THEME_BOREALIS_VERSION = 0.9a
SOUND_THEME_BOREALIS_SITE = http://ico.bukvic.net/Linux/Borealis_soundtheme
SOUND_THEME_BOREALIS_SOURCE = \
	Borealis_sound_theme_ogg-$(SOUND_THEME_BOREALIS_VERSION).tar.bz2
SOUND_THEME_BOREALIS_LICENSE = Artistic License (non-GPL/LGPL commercial use prohibited)
SOUND_THEME_BOREALIS_LICENSE_FILES = README

define SOUND_THEME_BOREALIS_INSTALL_TARGET_CMDS
	for f in $(@D)/*.ogg ; do \
		$(INSTALL) -D -m 0644 $$f $(TARGET_DIR)/usr/share/sounds/borealis/stereo/`basename $$f` || exit 1; \
	done
endef

$(eval $(generic-package))

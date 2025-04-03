################################################################################
#
# tmux
#
################################################################################

TMUX_VERSION = 3.5a
TMUX_SITE = https://github.com/tmux/tmux/releases/download/$(TMUX_VERSION)
TMUX_LICENSE = ISC
TMUX_LICENSE_FILES = COPYING
TMUX_CPE_ID_VALID = YES
TMUX_DEPENDENCIES = host-bison libevent ncurses host-pkgconf

ifeq ($(BR2_PACKAGE_JEMALLOC),y)
TMUX_DEPENDENCIES += jemalloc
TMUX_CONF_OPTS += --enable-jemalloc
else
TMUX_CONF_OPTS += --disable-jemalloc
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
TMUX_DEPENDENCIES += systemd
TMUX_CONF_OPTS += --enable-systemd
else
TMUX_CONF_OPTS += --disable-systemd
endif

ifeq ($(BR2_PACKAGE_UTF8PROC),y)
TMUX_DEPENDENCIES += utf8proc
TMUX_CONF_OPTS += --enable-utf8proc
else
TMUX_CONF_OPTS += --disable-utf8proc
endif

# tmux uses custom --enable-static option, instead of standard libtool
# directive resulting in a build failure with systemd or utf8proc
ifeq ($(BR2_SHARED_STATIC_LIBS),y)
TMUX_CONF_OPTS += --disable-static
endif

# Add /usr/bin/tmux to /etc/shells otherwise some login tools like dropbear
# can reject the user connection. See man shells.
define TMUX_ADD_TMUX_TO_SHELLS
	grep -qsE '^/usr/bin/tmux$$' $(TARGET_DIR)/etc/shells \
		|| echo "/usr/bin/tmux" >> $(TARGET_DIR)/etc/shells
endef
TMUX_TARGET_FINALIZE_HOOKS += TMUX_ADD_TMUX_TO_SHELLS

$(eval $(autotools-package))

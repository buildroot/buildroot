################################################################################
#
# zsh
#
################################################################################

ZSH_VERSION = 5.9
ZSH_SITE = http://www.zsh.org/pub
ZSH_SOURCE = zsh-$(ZSH_VERSION).tar.xz
ZSH_DEPENDENCIES = ncurses
ZSH_CONF_OPTS = --bindir=/bin
ZSH_CONF_ENV = zsh_cv_sys_nis=no zsh_cv_sys_nis_plus=no
ZSH_LICENSE = MIT-like
ZSH_LICENSE_FILES = LICENCE
ZSH_CPE_ID_VENDOR = zsh

# zsh uses TRY_RUN to determine these
ZSH_CONF_OPTS += \
	zsh_cv_long_is_64_bit=$(if $(BR2_ARCH_IS_64),yes,no) \
	zsh_cv_off_t_is_64_bit=yes \
	zsh_cv_64_bit_type='long long' \
	zsh_cv_64_bit_utype='unsigned long long' \
	zsh_cv_printf_has_lld=yes

ifeq ($(BR2_PACKAGE_GDBM),y)
ZSH_CONF_OPTS += --enable-gdbm
ZSH_DEPENDENCIES += gdbm
else
ZSH_CONF_OPTS += --disable-gdbm
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
ZSH_CONF_OPTS += --enable-cap
ZSH_DEPENDENCIES += libcap
else
ZSH_CONF_OPTS += --disable-cap
endif

ifeq ($(BR2_PACKAGE_PCRE),y)
ZSH_CONF_OPTS += --enable-pcre
ZSH_CONF_ENV += ac_cv_prog_PCRECONF=$(STAGING_DIR)/usr/bin/pcre-config
ZSH_DEPENDENCIES += pcre
else
ZSH_CONF_OPTS += --disable-pcre
endif

ifeq ($(BR2_STATIC_LIBS),)
# zsh uses TRY_RUN to determine these
ZSH_CONF_OPTS += \
	zsh_cv_shared_environ=yes \
	zsh_cv_shared_tgetent=yes \
	zsh_cv_shared_tigetstr=yes \
	zsh_cv_sys_dynamic_clash_ok=yes \
	zsh_cv_sys_dynamic_rtld_global=yes \
	zsh_cv_sys_dynamic_execsyms=yes \
	zsh_cv_sys_dynamic_strip_exe=yes \
	zsh_cv_sys_dynamic_strip_lib=yes
endif

# regex is commonly used by completion scripts, link it statically
define ZSH_USE_STATIC_REGEX_MODULE
	$(SED) 's,echo dynamic,echo static,' $(@D)/Src/Modules/regex.mdd
endef
ZSH_POST_PATCH_HOOKS += ZSH_USE_STATIC_REGEX_MODULE

# Add /bin/zsh to /etc/shells otherwise some login tools like dropbear
# can reject the user connection. See man shells.
define ZSH_ADD_ZSH_TO_SHELLS
	grep -qsE '^/bin/zsh$$' $(TARGET_DIR)/etc/shells \
		|| echo "/bin/zsh" >> $(TARGET_DIR)/etc/shells
endef
ZSH_TARGET_FINALIZE_HOOKS += ZSH_ADD_ZSH_TO_SHELLS

# Remove versioned zsh-x.y.z binary taking up space
define ZSH_TARGET_INSTALL_FIXUPS
	rm -f $(TARGET_DIR)/bin/zsh-$(ZSH_VERSION)
endef
ZSH_POST_INSTALL_TARGET_HOOKS += ZSH_TARGET_INSTALL_FIXUPS

$(eval $(autotools-package))

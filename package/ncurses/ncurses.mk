################################################################################
#
# ncurses
#
################################################################################

NCURSES_VERSION = 6.3
NCURSES_SITE = $(BR2_GNU_MIRROR)/ncurses
NCURSES_INSTALL_STAGING = YES
NCURSES_DEPENDENCIES = host-ncurses
NCURSES_LICENSE = MIT with advertising clause
NCURSES_LICENSE_FILES = COPYING
NCURSES_CPE_ID_VENDOR = gnu
NCURSES_CONFIG_SCRIPTS = ncurses$(NCURSES_LIB_SUFFIX)6-config
# patch 20220416
NCURSES_IGNORE_CVES += CVE-2022-29458
NCURSES_PATCH = \
	$(addprefix https://invisible-mirror.net/archives/ncurses/$(NCURSES_VERSION)/, \
		ncurses-6.3-20211026.patch.gz \
		ncurses-6.3-20211030.patch.gz \
		ncurses-6.3-20211106.patch.gz \
		ncurses-6.3-20211113.patch.gz \
		ncurses-6.3-20211115.patch.gz \
		ncurses-6.3-20211120.patch.gz \
		ncurses-6.3-20211127.patch.gz \
		ncurses-6.3-20211204.patch.gz \
		ncurses-6.3-20211211.patch.gz \
		ncurses-6.3-20211219.patch.gz \
		ncurses-6.3-20211225.patch.gz \
		ncurses-6.3-20220101.patch.gz \
		ncurses-6.3-20220115.patch.gz \
		ncurses-6.3-20220122.patch.gz \
		ncurses-6.3-20220129.patch.gz \
		ncurses-6.3-20220205.patch.gz \
		ncurses-6.3-20220212.patch.gz \
		ncurses-6.3-20220219.patch.gz \
		ncurses-6.3-20220226.patch.gz \
		ncurses-6.3-20220305.patch.gz \
		ncurses-6.3-20220312.patch.gz \
		ncurses-6.3-20220319.patch.gz \
		ncurses-6.3-20220326.patch.gz \
		ncurses-6.3-20220402.patch.gz \
		ncurses-6.3-20220409.patch.gz \
		ncurses-6.3-20220416.patch.gz \
		ncurses-6.3-20220423.patch.gz \
		ncurses-6.3-20220430.patch.gz \
		ncurses-6.3-20220501.patch.gz \
		ncurses-6.3-20220507.patch.gz \
		ncurses-6.3-20220514.patch.gz \
		ncurses-6.3-20220521.patch.gz \
		ncurses-6.3-20220529.patch.gz \
		ncurses-6.3-20220604.patch.gz \
		ncurses-6.3-20220612.patch.gz \
		ncurses-6.3-20220618.patch.gz \
		ncurses-6.3-20220625.patch.gz \
		ncurses-6.3-20220703.patch.gz \
		ncurses-6.3-20220709.patch.gz \
		ncurses-6.3-20220716.patch.gz \
		ncurses-6.3-20220724.patch.gz \
		ncurses-6.3-20220729.patch.gz \
		ncurses-6.3-20220806.patch.gz \
		ncurses-6.3-20220813.patch.gz \
		ncurses-6.3-20220820.patch.gz \
		ncurses-6.3-20220827.patch.gz \
		ncurses-6.3-20220903.patch.gz \
		ncurses-6.3-20220910.patch.gz \
		ncurses-6.3-20220917.patch.gz \
		ncurses-6.3-20220924.patch.gz \
		ncurses-6.3-20221001.patch.gz \
		ncurses-6.3-20221008.patch.gz \
		ncurses-6.3-20221015.patch.gz \
		ncurses-6.3-20221023.patch.gz \
		ncurses-6.3-20221029.patch.gz \
		ncurses-6.3-20221105.patch.gz \
		ncurses-6.3-20221112.patch.gz \
		ncurses-6.3-20221119.patch.gz \
		ncurses-6.3-20221126.patch.gz \
		ncurses-6.3-20221203.patch.gz \
	)

NCURSES_CONF_OPTS = \
	--without-cxx \
	--without-cxx-binding \
	--without-ada \
	--without-tests \
	--disable-big-core \
	--without-profile \
	--disable-rpath \
	--disable-rpath-hack \
	--enable-echo \
	--enable-const \
	--enable-overwrite \
	--enable-pc-files \
	--disable-stripping \
	--with-pkg-config-libdir="/usr/lib/pkgconfig" \
	$(if $(BR2_PACKAGE_NCURSES_TARGET_PROGS),,--without-progs) \
	--without-manpages

ifeq ($(BR2_STATIC_LIBS),y)
NCURSES_CONF_OPTS += --without-shared --with-normal
else ifeq ($(BR2_SHARED_LIBS),y)
NCURSES_CONF_OPTS += --with-shared --without-normal
else ifeq ($(BR2_SHARED_STATIC_LIBS),y)
NCURSES_CONF_OPTS += --with-shared --with-normal
endif

# configure can't find the soname for libgpm when cross compiling
ifeq ($(BR2_PACKAGE_GPM),y)
NCURSES_CONF_OPTS += --with-gpm=libgpm.so.2
NCURSES_DEPENDENCIES += gpm
else
NCURSES_CONF_OPTS += --without-gpm
endif

NCURSES_TERMINFO_FILES = \
	a/ansi \
	d/dumb \
	l/linux \
	p/putty \
	p/putty-256color \
	p/putty-vt100 \
	s/screen \
	s/screen-256color \
	v/vt100 \
	v/vt100-putty \
	v/vt102 \
	v/vt200 \
	v/vt220 \
	x/xterm \
	x/xterm+256color \
	x/xterm-256color \
	x/xterm-color \
	x/xterm-xfree86 \
	$(call qstrip,$(BR2_PACKAGE_NCURSES_ADDITIONAL_TERMINFO))

ifeq ($(BR2_PACKAGE_NCURSES_WCHAR),y)
NCURSES_CONF_OPTS += --enable-widec
NCURSES_LIB_SUFFIX = w
NCURSES_LIBS = ncurses menu panel form

define NCURSES_LINK_LIBS_STATIC
	$(foreach lib,$(NCURSES_LIBS:%=lib%), \
		ln -sf $(lib)$(NCURSES_LIB_SUFFIX).a $(STAGING_DIR)/usr/lib/$(lib).a
	)
	ln -sf libncurses$(NCURSES_LIB_SUFFIX).a \
		$(STAGING_DIR)/usr/lib/libcurses.a
endef

define NCURSES_LINK_LIBS_SHARED
	$(foreach lib,$(NCURSES_LIBS:%=lib%), \
		ln -sf $(lib)$(NCURSES_LIB_SUFFIX).so $(STAGING_DIR)/usr/lib/$(lib).so
	)
	ln -sf libncurses$(NCURSES_LIB_SUFFIX).so \
		$(STAGING_DIR)/usr/lib/libcurses.so
endef

define NCURSES_LINK_PC
	$(foreach pc,$(NCURSES_LIBS), \
		ln -sf $(pc)$(NCURSES_LIB_SUFFIX).pc \
			$(STAGING_DIR)/usr/lib/pkgconfig/$(pc).pc
	)
endef

NCURSES_LINK_STAGING_LIBS = \
	$(if $(BR2_STATIC_LIBS)$(BR2_SHARED_STATIC_LIBS),$(call NCURSES_LINK_LIBS_STATIC);) \
	$(if $(BR2_SHARED_LIBS)$(BR2_SHARED_STATIC_LIBS),$(call NCURSES_LINK_LIBS_SHARED))

NCURSES_LINK_STAGING_PC = $(call NCURSES_LINK_PC)

NCURSES_CONF_OPTS += --enable-ext-colors

NCURSES_POST_INSTALL_STAGING_HOOKS += NCURSES_LINK_STAGING_LIBS
NCURSES_POST_INSTALL_STAGING_HOOKS += NCURSES_LINK_STAGING_PC

endif # BR2_PACKAGE_NCURSES_WCHAR

ifneq ($(BR2_ENABLE_DEBUG),y)
NCURSES_CONF_OPTS += --without-debug
endif

# ncurses breaks with parallel build, but takes quite a while to
# build single threaded. Work around it similar to how Gentoo does
define NCURSES_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) DESTDIR=$(STAGING_DIR) sources
	rm -rf $(@D)/misc/pc-files
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(STAGING_DIR)
endef

ifeq ($(BR2_PACKAGE_NCURSES_TARGET_PROGS),y)
define NCURSES_TARGET_SYMLINK_RESET
	ln -sf tset $(TARGET_DIR)/usr/bin/reset
endef
NCURSES_POST_INSTALL_TARGET_HOOKS += NCURSES_TARGET_SYMLINK_RESET
endif

define NCURSES_TARGET_CLEANUP_TERMINFO
	$(RM) -rf $(TARGET_DIR)/usr/share/terminfo $(TARGET_DIR)/usr/share/tabset
	$(foreach t,$(NCURSES_TERMINFO_FILES), \
		$(INSTALL) -D -m 0644 $(STAGING_DIR)/usr/share/terminfo/$(t) \
			$(TARGET_DIR)/usr/share/terminfo/$(t)
	)
endef
NCURSES_POST_INSTALL_TARGET_HOOKS += NCURSES_TARGET_CLEANUP_TERMINFO

HOST_NCURSES_CONF_ENV = \
	ac_cv_path_LDCONFIG=""

HOST_NCURSES_CONF_OPTS = \
	--with-shared \
	--without-gpm \
	--without-manpages \
	--without-cxx \
	--without-cxx-binding \
	--without-ada \
	--with-default-terminfo-dir=/usr/share/terminfo \
	--disable-db-install \
	--without-normal

$(eval $(autotools-package))
$(eval $(host-autotools-package))

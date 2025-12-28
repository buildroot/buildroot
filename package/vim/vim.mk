################################################################################
#
# vim
#
################################################################################

VIM_VERSION = 9.1.2017
VIM_SITE = $(call github,vim,vim,v$(VIM_VERSION))
VIM_DEPENDENCIES = ncurses $(TARGET_NLS_DEPENDENCIES)
VIM_SUBDIR = src
VIM_CONF_ENV = \
	vim_cv_toupper_broken=no \
	vim_cv_terminfo=yes \
	vim_cv_tgetent=zero \
	vim_cv_tty_group=world \
	vim_cv_tty_mode=0620 \
	vim_cv_getcwd_broken=no \
	vim_cv_stat_ignores_slash=yes \
	vim_cv_memmove_handles_overlap=yes \
	ac_cv_sizeof_int=4 \
	ac_cv_small_wchar_t=no
# GUI/X11 headers leak from the host so forcibly disable them
VIM_CONF_OPTS = --with-tlib=ncurses --enable-gui=no --without-x
VIM_LICENSE = Charityware
VIM_LICENSE_FILES = LICENSE README.txt
VIM_CPE_ID_VENDOR = vim

ifeq ($(BR2_PACKAGE_ACL),y)
VIM_CONF_OPTS += --enable-acl
VIM_DEPENDENCIES += acl
else
VIM_CONF_OPTS += --disable-acl
endif

ifeq ($(BR2_PACKAGE_GPM),y)
VIM_CONF_OPTS += --enable-gpm
VIM_DEPENDENCIES += gpm
else
VIM_CONF_OPTS += --disable-gpm
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
VIM_CONF_OPTS += --enable-selinux
VIM_DEPENDENCIES += libselinux
else
VIM_CONF_OPTS += --disable-selinux
endif

VIM_INSTALL_TARGETS = \
	installvimbin installpack \
	installtools installlinks

ifeq ($(BR2_PACKAGE_VIM_RUNTIME),y)
VIM_INSTALL_TARGETS += installrtbase installmacros
endif

define VIM_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/src DESTDIR=$(TARGET_DIR) \
		$(VIM_INSTALL_TARGETS)
	$(RM) -rf $(TARGET_DIR)/usr/share/vim/vim*/doc/
endef

# Avoid oopses with vipw/vigr (from package shadow), lack of $EDITOR,
# or other packages expecting plain 'vi' command to exist.
ifeq ($(BR2_ROOTFS_MERGED_USR),y)
define VIM_INSTALL_VI_SYMLINK
	ln -sf vim $(TARGET_DIR)/usr/bin/vi
endef
else
define VIM_INSTALL_VI_SYMLINK
	ln -sf ../usr/bin/vim $(TARGET_DIR)/bin/vi
endef
endif
VIM_POST_INSTALL_TARGET_HOOKS += VIM_INSTALL_VI_SYMLINK

HOST_VIM_DEPENDENCIES = host-ncurses
HOST_VIM_CONF_OPTS = \
	--with-tlib=ncurses \
	--enable-gui=no \
	--without-x \
	--disable-acl \
	--disable-gpm \
	--disable-selinux

$(eval $(autotools-package))
$(eval $(host-autotools-package))

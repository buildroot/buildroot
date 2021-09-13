################################################################################
#
# lxc
#
################################################################################

LXC_VERSION = 4.0.10
LXC_SITE = https://linuxcontainers.org/downloads/lxc
LXC_LICENSE = GPL-2.0 (some tools), LGPL-2.1+
LXC_LICENSE_FILES = LICENSE.GPL2 LICENSE.LGPL2.1
LXC_CPE_ID_VENDOR = linuxcontainers
LXC_DEPENDENCIES = host-pkgconf
LXC_INSTALL_STAGING = YES

LXC_CONF_OPTS = \
	--disable-apparmor \
	--disable-examples \
	--with-distro=buildroot \
	--disable-werror \
	$(if $(BR2_PACKAGE_BASH),,--disable-bash)

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
LXC_DEPENDENCIES += bash-completion
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
LXC_CONF_OPTS += --enable-capabilities
LXC_DEPENDENCIES += libcap
else
LXC_CONF_OPTS += --disable-capabilities
endif

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
LXC_CONF_OPTS += --enable-seccomp
LXC_DEPENDENCIES += libseccomp
else
LXC_CONF_OPTS += --disable-seccomp
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
LXC_CONF_OPTS += --enable-selinux
LXC_DEPENDENCIES += libselinux
else
LXC_CONF_OPTS += --disable-selinux
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LXC_CONF_OPTS += --enable-openssl
LXC_DEPENDENCIES += openssl
else
LXC_CONF_OPTS += --disable-openssl
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
LXC_DEPENDENCIES += linux-pam
LXC_CONF_OPTS += --enable-pam
else
LXC_CONF_OPTS += --disable-pam
endif

define LXC_USERS
	lxc -1 lxc -1 * /var/lib/lxcunpriv - -
endef

define LXC_POST_INSTALL_TARGET_COPY_SUBXID
	$(INSTALL) -m 0644 -D package/lxc/subuid \
		$(TARGET_DIR)/etc/subuid
	$(INSTALL) -m 0644 -D package/lxc/subgid \
		$(TARGET_DIR)/etc/subgid
endef
LXC_POST_INSTALL_TARGET_HOOKS += LXC_POST_INSTALL_TARGET_COPY_SUBXID

define LXC_POST_INSTALL_MKDIR_HOME
	mkdir -p $(TARGET_DIR)/var/lib/lxcunpriv
endef
LXC_POST_INSTALL_TARGET_HOOKS += LXC_POST_INSTALL_MKDIR_HOME

define LXC_PERMISSIONS
	/usr/libexec/lxc/lxc-user-nic f  4755  root  root   -  -  -  -  -
	/var/lib/lxcunpriv d  0755  lxc   lxc    -  -  -  -  -
endef

$(eval $(autotools-package))

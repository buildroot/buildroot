################################################################################
#
# lxc
#
################################################################################

LXC_VERSION = 5.0.1
LXC_SITE = https://linuxcontainers.org/downloads/lxc
LXC_LICENSE = GPL-2.0 (some tools), LGPL-2.1+
LXC_LICENSE_FILES = LICENSE.GPL2 LICENSE.LGPL2.1
LXC_CPE_ID_VENDOR = linuxcontainers
LXC_DEPENDENCIES = host-pkgconf
LXC_INSTALL_STAGING = YES

LXC_CONF_OPTS = \
	-Dapparmor=false \
	-Dexamples=false \
	-Dman=false

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
LXC_DEPENDENCIES += bash-completion
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
LXC_CONF_OPTS += -Dcapabilities=true
LXC_DEPENDENCIES += libcap
else
LXC_CONF_OPTS += -Dcapabilities=false
endif

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
LXC_CONF_OPTS += -Dseccomp=true
LXC_DEPENDENCIES += libseccomp
else
LXC_CONF_OPTS += -Dseccomp=false
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
LXC_CONF_OPTS += -Dselinux=true
LXC_DEPENDENCIES += libselinux
else
LXC_CONF_OPTS += -Dselinux=false
endif

ifeq ($(BR2_PACKAGE_LIBURING),y)
LXC_CONF_OPTS += -Dio-uring-event-loop=true
LXC_DEPENDENCIES += liburing
else
LXC_CONF_OPTS += -Dio-uring-event-loop=false
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
LXC_CONF_OPTS += -Dpam-cgroup=true
LXC_DEPENDENCIES += linux-pam
else
LXC_CONF_OPTS += -Dpam-cgroup=false
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LXC_CONF_OPTS += -Dopenssl=true
LXC_DEPENDENCIES += openssl
else
LXC_CONF_OPTS += -Dopenssl=false
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

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
LXC_CONF_OPTS += -Dsd-bus=enabled
LXC_DEPENDENCIES += systemd
else
LXC_CONF_OPTS += -Dsd-bus=disabled
endif

ifeq ($(BR2_INIT_SYSTEMD),y)
LXC_CONF_OPTS += -Dinit-script=systemd
else ifeq ($(BR2_INIT_SYSV),y)
LXC_CONF_OPTS += -Dinit-script=sysvinit
else
LXC_CONF_OPTS += -Dinit-script=
endif

$(eval $(meson-package))

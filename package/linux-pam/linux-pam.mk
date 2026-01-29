################################################################################
#
# linux-pam
#
################################################################################

LINUX_PAM_VERSION = 1.7.2
LINUX_PAM_SOURCE = Linux-PAM-$(LINUX_PAM_VERSION).tar.xz
LINUX_PAM_SITE = https://github.com/linux-pam/linux-pam/releases/download/v$(LINUX_PAM_VERSION)
LINUX_PAM_INSTALL_STAGING = YES
LINUX_PAM_CONF_OPTS = \
	-Disadir=disabled \
	-Dnis=disabled \
	-Dpam_userdb=disabled \
	-Ddocs=disabled
LINUX_PAM_DEPENDENCIES = host-flex host-pkgconf \
	$(if $(BR2_PACKAGE_LIBXCRYPT),libxcrypt) \
	$(TARGET_NLS_DEPENDENCIES)
LINUX_PAM_LICENSE = BSD-3-Clause
LINUX_PAM_LICENSE_FILES = Copyright
LINUX_PAM_LIBS = $(TARGET_NLS_LIBS)
LINUX_PAM_MAKE_OPTS += LIBS="$(LINUX_PAM_LIBS)"
LINUX_PAM_CPE_ID_VENDOR = linux-pam

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
LINUX_PAM_LIBS += -latomic
endif

ifeq ($(BR2_PACKAGE_LIBSELINUX),y)
LINUX_PAM_CONF_OPTS += -Dselinux=enabled
LINUX_PAM_DEPENDENCIES += libselinux
define LINUX_PAM_SELINUX_PAMFILE_TWEAK
	$(SED) 's/^# \(.*pam_selinux.so.*\)$$/\1/' \
		$(TARGET_DIR)/etc/pam.d/login
endef
else
LINUX_PAM_CONF_OPTS += -Dselinux=disabled
endif

ifeq ($(BR2_PACKAGE_AUDIT),y)
LINUX_PAM_CONF_OPTS += -Daudit=enabled
LINUX_PAM_DEPENDENCIES += audit
else
LINUX_PAM_CONF_OPTS += -Daudit=disabled
endif

ifeq ($(BR2_PACKAGE_OPENSSL),y)
LINUX_PAM_CONF_OPTS += -Dopenssl=enabled
LINUX_PAM_DEPENDENCIES += openssl
else
LINUX_PAM_CONF_OPTS += -Dopenssl=disabled
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM_LASTLOG),y)
LINUX_PAM_CONF_OPTS += -Dpam_lastlog=enabled
define LINUX_PAM_LASTLOG_PAMFILE_TWEAK
	$(SED) 's/^# \(.*pam_lastlog.so.*\)$$/\1/' \
		$(TARGET_DIR)/etc/pam.d/login
endef
else
LINUX_PAM_CONF_OPTS += -Dpam_lastlog=disabled
endif

# Install default pam config (deny everything except login)
define LINUX_PAM_INSTALL_CONFIG
	$(INSTALL) -m 0644 -D package/linux-pam/login.pam \
		$(TARGET_DIR)/etc/pam.d/login
	$(INSTALL) -m 0644 -D package/linux-pam/other.pam \
		$(TARGET_DIR)/etc/pam.d/other
	$(LINUX_PAM_LASTLOG_PAMFILE_TWEAK)
	$(LINUX_PAM_SELINUX_PAMFILE_TWEAK)
endef

LINUX_PAM_POST_INSTALL_TARGET_HOOKS += LINUX_PAM_INSTALL_CONFIG

$(eval $(meson-package))

################################################################################
#
# policycoreutils
#
################################################################################

POLICYCOREUTILS_VERSION = 3.8.1
POLICYCOREUTILS_SITE = https://github.com/SELinuxProject/selinux/releases/download/$(POLICYCOREUTILS_VERSION)
POLICYCOREUTILS_LICENSE = GPL-2.0
POLICYCOREUTILS_LICENSE_FILES = LICENSE
POLICYCOREUTILS_CPE_ID_VENDOR = selinuxproject

POLICYCOREUTILS_DEPENDENCIES = libsemanage libsepol libcap-ng $(TARGET_NLS_DEPENDENCIES)
POLICYCOREUTILS_MAKE_OPTS = $(TARGET_CONFIGURE_OPTS) LDLIBS=$(TARGET_NLS_LIBS)

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
POLICYCOREUTILS_DEPENDENCIES += libxcrypt
endif

ifeq ($(BR2_PACKAGE_LINUX_PAM),y)
POLICYCOREUTILS_DEPENDENCIES += linux-pam
POLICYCOREUTILS_MAKE_OPTS += NAMESPACE_PRIV=y
endif

ifeq ($(BR2_PACKAGE_AUDIT),y)
POLICYCOREUTILS_DEPENDENCIES += audit
POLICYCOREUTILS_MAKE_OPTS += AUDIT_LOG_PRIV=y USE_AUDIT=y
endif

# Enable LSPP_PRIV if both audit and linux pam are enabled
ifeq ($(BR2_PACKAGE_LINUX_PAM)$(BR2_PACKAGE_AUDIT),yy)
POLICYCOREUTILS_MAKE_OPTS += LSPP_PRIV=y
endif

POLICYCOREUTILS_MAKE_DIRS = \
	load_policy newrole run_init \
	secon semodule sestatus setfiles \
	setsebool scripts

# We need to pass DESTDIR at build time because it's used by
# policycoreutils build system to find headers and libraries.
define POLICYCOREUTILS_BUILD_CMDS
	$(foreach d,$(POLICYCOREUTILS_MAKE_DIRS),
		$(MAKE) -C $(@D)/$(d) $(POLICYCOREUTILS_MAKE_OPTS) \
			DESTDIR=$(STAGING_DIR) all
	)
endef

define POLICYCOREUTILS_INSTALL_TARGET_CMDS
	$(foreach d,$(POLICYCOREUTILS_MAKE_DIRS),
		$(MAKE) -C $(@D)/$(d) $(POLICYCOREUTILS_MAKE_OPTS) \
			DESTDIR=$(TARGET_DIR) install
	)
endef

HOST_POLICYCOREUTILS_DEPENDENCIES = host-libsemanage

# We need to pass PREFIX because it defaults to $(DESTDIR)/usr
HOST_POLICYCOREUTILS_MAKE_OPTS = \
	$(HOST_CONFIGURE_OPTS) \
	PREFIX=$(HOST_DIR) \
	ETCDIR=$(HOST_DIR)/etc \
	SBINDIR=$(HOST_DIR)/sbin

# Note: We are only building the programs required by the refpolicy build
HOST_POLICYCOREUTILS_MAKE_DIRS = \
	load_policy newrole run_init \
	secon semodule sestatus setfiles \
	setsebool

define HOST_POLICYCOREUTILS_BUILD_CMDS
	$(foreach d,$(HOST_POLICYCOREUTILS_MAKE_DIRS),
		$(MAKE) -C $(@D)/$(d) $(HOST_POLICYCOREUTILS_MAKE_OPTS) all
	)
endef

define HOST_POLICYCOREUTILS_INSTALL_CMDS
	$(foreach d,$(HOST_POLICYCOREUTILS_MAKE_DIRS),
		$(MAKE) -C $(@D)/$(d) $(HOST_POLICYCOREUTILS_MAKE_OPTS) install
	)
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

################################################################################
#
# pax-utils
#
################################################################################

PAX_UTILS_VERSION = 1.3.7
PAX_UTILS_SITE = https://gitweb.gentoo.org/proj/pax-utils.git/snapshot
PAX_UTILS_SOURCE = pax-utils-$(PAX_UTILS_VERSION).tar.bz2
PAX_UTILS_LICENSE = GPL-2.0
PAX_UTILS_LICENSE_FILES = COPYING
PAX_UTILS_CPE_ID_VENDOR = gentoo

PAX_UTILS_DEPENDENCIES = host-pkgconf
PAX_UTILS_CONF_OPTS = \
	-Dbuild_manpages=disabled \
	-Dlddtree_implementation=sh \
	-Dtests=false

ifeq ($(BR2_PACKAGE_LIBCAP),y)
PAX_UTILS_DEPENDENCIES += libcap
PAX_UTILS_CONF_OPTS += -Duse_libcap=enabled
else
PAX_UTILS_CONF_OPTS += -Duse_libcap=disabled
endif

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
PAX_UTILS_DEPENDENCIES += libseccomp
PAX_UTILS_CONF_OPTS += -Duse_seccomp=true
else
PAX_UTILS_CONF_OPTS += -Duse_seccomp=false
endif

# lddtree and symtree need bash
ifeq ($(BR2_PACKAGE_BASH),)
define PAX_UTILS_REMOVE_BASH_TOOLS
	rm -f $(TARGET_DIR)/usr/bin/{lddtree,symtree}
endef
endif
PAX_UTILS_POST_INSTALL_TARGET_HOOKS += PAX_UTILS_REMOVE_BASH_TOOLS

$(eval $(meson-package))
$(eval $(host-meson-package))

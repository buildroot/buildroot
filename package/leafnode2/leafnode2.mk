################################################################################
#
# leafnode2
#
################################################################################

LEAFNODE2_VERSION = 2.0.0.alpha202601
LEAFNODE2_SITE = $(call gitlab,leafnode-2,leafnode-2,leafnode-$(LEAFNODE2_VERSION))
LEAFNODE2_LICENSE = LGPL-2.1
LEAFNODE2_LICENSE_FILES = COPYING COPYING.LGPL
LEAFNODE2_DEPENDENCIES = host-pcre2 pcre2
LEAFNODE2_AUTORECONF = YES

# pod2man doesn't work when cross compiling
define LEAFNODE2_DISABLE_POD2MAN
	$(SED) 's/GENERATED_MANS=lsmac.1/GENERATED_MANS=/' $(@D)/Makefile.am
endef
LEAFNODE2_POST_PATCH_HOOKS += LEAFNODE2_DISABLE_POD2MAN

LEAFNODE2_CONF_ENV = \
	PCRE2CONFIG="$(STAGING_DIR)/usr/bin/pcre2-config"

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
LEAFNODE2_DEPENDENCIES += libxcrypt
endif

# --enable-runas-user use 'news' as default but the configure stop
# if news doesn't exist on the build host.
# Use 'root' while cross-compiling
LEAFNODE2_CONF_OPTS = \
	--sysconfdir=/etc/leafnode2 \
	--enable-spooldir=/var/spool/news \
	--enable-runas-user=root

# Leafnode2 needs the host version of b_sortnl during
# compilation. Instead of creating a separate host package and
# installing b_sortnl to $(HOST_DIR) this binary is compiled
# on-the-fly, host-pcre2 is needed for this
define LEAFNODE2_BUILD_SORTNL_TOOL
	cd $(@D); \
	$(HOSTCC) $(HOST_CFLAGS) -o b_sortnl_host \
		arc4random.c mergesort.c b_sortnl.c critmem_malloc.c \
		critmem_realloc.c -DHAVE_CONFIG_H -I$(HOST_DIR)/include \
		-L $(HOST_DIR)/lib -Wl,-rpath,$(HOST_DIR)/lib -lpcre2-8
endef

LEAFNODE2_PRE_BUILD_HOOKS += LEAFNODE2_BUILD_SORTNL_TOOL

define LEAFNODE2_USERS
	news -1 news -1 * - - - Leafnode2 daemon
endef

$(eval $(autotools-package))

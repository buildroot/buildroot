################################################################################
#
# leafnode2
#
################################################################################

LEAFNODE2_VERSION = ce7d3b13fb285c9fb7bffc382ea10fd41e12582d
LEAFNODE2_SITE = $(call gitlab,leafnode-2,leafnode-2,$(LEAFNODE2_VERSION))
LEAFNODE2_LICENSE = LGPL-2.1
LEAFNODE2_LICENSE_FILES = COPYING COPYING.LGPL
LEAFNODE2_DEPENDENCIES = host-pcre pcre
LEAFNODE2_AUTORECONF = YES

LEAFNODE2_CONF_ENV = \
	PCRECONFIG="$(STAGING_DIR)/usr/bin/pcre-config"

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
# on-the-fly, host-pcre is needed for this
define LEAFNODE2_BUILD_SORTNL_TOOL
	cd $(@D); \
	$(HOSTCC) $(HOST_CFLAGS) -o b_sortnl_host \
		arc4random.c mergesort.c b_sortnl.c critmem_malloc.c \
		critmem_realloc.c -DHAVE_CONFIG_H -I$(HOST_DIR)/include \
		-L $(HOST_DIR)/lib -Wl,-rpath,$(HOST_DIR)/lib -lpcre
endef

LEAFNODE2_PRE_BUILD_HOOKS += LEAFNODE2_BUILD_SORTNL_TOOL

define LEAFNODE2_USERS
	news -1 news -1 * - - - Leafnode2 daemon
endef

$(eval $(autotools-package))

################################################################################
#
# lzma-alone
#
################################################################################

LZMA_ALONE_VERSION = 9.22
LZMA_ALONE_SITE = https://sourceforge.net/projects/sevenzip/files/LZMA%20SDK
LZMA_ALONE_SOURCE = lzma922.tar.bz2
LZMA_ALONE_STRIP_COMPONENTS = 0
LZMA_ALONE_LICENSE = Public Domain
LZMA_ALONE_LICENSE_FILES = lzma.txt

define HOST_LZMA_ALONE_BUILD_CMDS
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) \
		-C $(@D)/C/Util/Lzma -f makefile.gcc
	$(HOST_MAKE_ENV) $(HOST_CONFIGURE_OPTS) $(MAKE) \
		-C $(@D)/CPP/7zip/Bundles/LzmaCon -f makefile.gcc
endef

define HOST_LZMA_ALONE_INSTALL_CMDS
	$(INSTALL) -D -m 0755 \
		$(@D)/CPP/7zip/Bundles/LzmaCon/lzma \
		$(HOST_DIR)/bin/lzma_alone
endef

$(eval $(host-generic-package))

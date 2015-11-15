################################################################################
#
# icu
#
################################################################################

ICU_VERSION = 56.1
ICU_SOURCE = icu4c-$(subst .,_,$(ICU_VERSION))-src.tgz
ICU_SITE = http://download.icu-project.org/files/icu4c/$(ICU_VERSION)
ICU_LICENSE = ICU License
ICU_LICENSE_FILES = license.html

ICU_DEPENDENCIES = host-icu
ICU_INSTALL_STAGING = YES
ICU_CONFIG_SCRIPTS = icu-config
ICU_CONF_OPTS = \
	--with-cross-build=$(HOST_ICU_DIR)/source \
	--disable-samples \
	--disable-tests
HOST_ICU_CONF_OPTS = \
	--disable-samples \
	--disable-tests \
	--disable-extras \
	--disable-icuio \
	--disable-layout \
	--disable-renaming
ICU_SUBDIR = source
HOST_ICU_SUBDIR = source

ifeq ($(BR2_PACKAGE_ICU_CUSTOM_DATA_METROLOGICAL),y)
ICU_CUSTOM_DATA_VERSION = f576e17a3234e468322ce087f473ff89b60190ba
define ICU_CUSTOM_DATA_DOWNLOAD
	$(EXTRA_ENV) $(DL_WRAPPER) -b git \
		-o $(@D)/source/data/in/icudata.tar.gz \
		$(QUIET) \
		-- \
		https://github.com/Metrological/icudata.git \
		$(ICU_CUSTOM_DATA_VERSION) \
		icudata
endef
define ICU_CUSTOM_DATA_EXTRACT
	$(INFLATE.gz) $(@D)/source/data/in/icudata.tar.gz | \
		$(TAR) --strip-components=1 -C $(@D)/source/data/in/ $(TAR_OPTIONS) -
endef
ICU_POST_PATCH_HOOKS += ICU_CUSTOM_DATA_DOWNLOAD
ICU_POST_PATCH_HOOKS += ICU_CUSTOM_DATA_EXTRACT
endif

ICU_CUSTOM_DATA_PATH = $(call qstrip,$(BR2_PACKAGE_ICU_CUSTOM_DATA_PATH))

ifneq ($(ICU_CUSTOM_DATA_PATH),)
define ICU_COPY_CUSTOM_DATA
	cp $(ICU_CUSTOM_DATA_PATH) $(@D)/source/data/in/
endef
ICU_POST_PATCH_HOOKS += ICU_COPY_CUSTOM_DATA
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))

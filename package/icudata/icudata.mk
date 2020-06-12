################################################################################
#
# icudata
#
################################################################################

ifeq ($(ICU_BUILD_ICUDATA), y)
ICUDATA_SOURCE = icu4c-$(subst .,_,$(ICU_VERSION))-data.zip
ICUDATA_SITE = https://github.com/unicode-org/icu/releases/download/release-$(subst .,-,$(ICU_VERSION))
ICUDATA_LICENSE = ICU License
ICUDATA_LICENSE_FILES = license.html
ICUDATA_EXTRACT_CMDS = unzip > /dev/null 2>&1

define ICUDATA_EXTRACT
    rm -rf $(@D)/source/data
    unzip $(DL_DIR)/$(ICUDATA_SOURCE) -d $(@D)/source
endef
else
ICUDATA_VERSION = d8d56c495af970036f4afa3704f58609446a2853
ICUDATA_SITE = $(call github,Metrological,icudata,$(ICUDATA_VERSION))

define ICUDATA_EXTRACT
	$(INFLATE.gz) $(DL_DIR)/$(ICUDATA_SOURCE) | \
		$(TAR) --strip-components=1 -C $(@D)/source/data/in/ $(TAR_OPTIONS) -
endef
endif

$(eval $(generic-package))
$(eval $(host-generic-package))

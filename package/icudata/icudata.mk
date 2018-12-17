################################################################################
#
# icudata
#
################################################################################

ICUDATA_VERSION = d8d56c495af970036f4afa3704f58609446a2853
ICUDATA_SITE = $(call github,Metrological,icudata,$(ICUDATA_VERSION))

define ICUDATA_EXTRACT
	$(INFLATE.gz) $(DL_DIR)/$(ICUDATA_SOURCE) | \
		$(TAR) --strip-components=1 -C $(@D)/source/data/in/ $(TAR_OPTIONS) -
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

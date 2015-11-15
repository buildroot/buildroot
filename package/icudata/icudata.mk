################################################################################
#
# icudata
#
################################################################################

ICUDATA_VERSION = f576e17a3234e468322ce087f473ff89b60190ba
ICUDATA_SITE = $(call github,Metrological,icudata,$(ICUDATA_VERSION))

define ICUDATA_EXTRACT
	$(INFLATE.gz) $(DL_DIR)/$(ICUDATA_SOURCE) | \
		$(TAR) --strip-components=1 -C $(@D)/source/data/in/ $(TAR_OPTIONS) -
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

################################################################################
#
# icudata
#
################################################################################

ICUDATA_VERSION = 752a18e9591ff01f88f9d5191eb74e004c1a1109
ICUDATA_SITE = $(call github,Metrological,icudata,$(ICUDATA_VERSION))

define ICUDATA_EXTRACT
	$(INFLATE.gz) $(DL_DIR)/$(ICUDATA_SOURCE) | \
		$(TAR) --strip-components=1 -C $(@D)/source/data/in/ $(TAR_OPTIONS) -
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

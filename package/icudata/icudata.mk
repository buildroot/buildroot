################################################################################
#
# icudata
#
################################################################################

ICUDATA_VERSION = 414fb7451e956546471757c500ca3ad8d204002b
ICUDATA_SITE = $(call github,Metrological,icudata,$(ICUDATA_VERSION))

define ICUDATA_EXTRACT
	$(INFLATE.gz) $(DL_DIR)/$(ICUDATA_SOURCE) | \
		$(TAR) --strip-components=1 -C $(@D)/source/data/in/ $(TAR_OPTIONS) -
endef

$(eval $(generic-package))
$(eval $(host-generic-package))

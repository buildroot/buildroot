################################################################################
#
# icudata
#
################################################################################

ICUDATA_VERSION = c6e813deb8d75937ebb78b68fa6f828bd45550db
ICUDATA_SITE = $(call github,Metrological,icudata,$(ICUDATA_VERSION))

define ICUDATA_EXTRACT
	$(INFLATE.gz) $(DL_DIR)/$(ICUDATA_SOURCE) | \
		$(TAR) --strip-components=1 -C $(@D)/source/data/in/ $(TAR_OPTIONS) -
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
